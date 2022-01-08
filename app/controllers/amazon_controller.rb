class AmazonController < ApplicationController
  before_action :authenticate_user!
  before_action :valid_credentials?

  def search
    if valid_credentials?
      @images = params[:q] ? query(params[:q]) : []
      render 'amazon/search'
    else
      render 'amazon/credentials'
    end
  end

  def robot
    if valid_credentials?
      attach_amazon_details
      books_without_info = Book.no_amazon_info.all
      @total_book_without_info_count = books_without_info.size
      @total_book_count = Book.all.size
      @percentage = (@total_book_without_info_count.to_f / @total_book_count.to_f * 100).round(1)
      if @total_book_without_info_count > 0
        @hit = books_without_info.first
        @alternative_title = @hit.title.gsub(/\(.*\)/, '').strip
        @images = query(params[:q] || @hit.title) # handle nil
      else
        @images = []
      end
      render 'amazon/robot'
    else
      render 'amazon/credentials'
    end
  end

  def add_amazon_details
    attach_amazon_details
    redirect_back fallback_location: books_url
  end

  private

  def valid_credentials?
    ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
  end

  def attach_amazon_details
    if params[:id]
      if params[:skip]
        Book.update(params[:id], amazon_info: true, amazon_skipped: true)
        flash[:warning] = "Don't worry. The selected book will be skipped in the future."
      else
        Book.update(
          params[:id],
          amazon_title: params[:title],
          amazon_author: params[:author],
          amazon_asin: params[:asin],
          amazon_isbn: params[:isbn],
          amazon_publisher: params[:publisher],
          amazon_url: params[:url],
          amazon_image_url: params[:img_url],
          amazon_updated_at: Time.now,
          amazon_info: true)
        flash[:success] = 'The book <b>' + params[:title] + '</b> by <b>' + (params[:author].blank? ? 'Unknown Author' : params[:author]) + '</b> has been updated with Amazon details.'
      end
    end
  end

  def query(keyword)
    request = Vacuum.new(
      marketplace: 'GB',
      access_key: ENV['AWS_ACCESS_KEY_ID'],
      secret_key: ENV['AWS_SECRET_ACCESS_KEY'],
      partner_tag: 'foobar'
    )
    params = {
      # See documentation: http://docs.aws.amazon.com/AWSECommerceService/latest/DG/SearchIndices.html
      SearchIndex: 'Books',
      Keywords: keyword,
      ResponseGroup: %w(ItemAttributes Images).join(',')
    }

    response = request.search_items(query: params)
    root = Nokogiri::XML(response.body).remove_namespaces!
    parse_items(root)
  end

  def parse_items(node)
    # See documentation: http://docs.aws.amazon.com/AWSECommerceService/latest/DG/CHAP_response_elements.html
    node.xpath('//Items/Item').map do |item_node|
      create_item_from(item_node)
    end
  end

  def create_item_from(node)
    image_url = parse_value(node, './ImageSets/ImageSet/LargeImage/URL') || parse_value(node, './LargeImage/URL')
    unless image_url.nil?
      attributes = {}
      attributes[:asin] = parse_value(node, './ASIN')
      attributes[:isbn] = parse_value(node, './ItemAttributes/ISBN')
      attributes[:title] = parse_value(node, './ItemAttributes/Title')
      attributes[:author] = parse_value(node, './ItemAttributes/Author')
      attributes[:publisher] = parse_value(node, './ItemAttributes/Publisher')
      attributes[:publication] = parse_value(node, './ItemAttributes/PublicationDate')
      attributes[:url] = clean_amazon_url(parse_value(node, './DetailPageURL'))
      attributes[:img_url] = image_url
      attributes[:width] = parse_value(node, './ImageSets/ImageSet/LargeImage/Width') || parse_value(node, './LargeImage/Width')
      attributes[:height] = parse_value(node, './ImageSets/ImageSet/LargeImage/Height') || parse_value(node, './LargeImage/Height')
      attributes
    end
  end

  def parse_value(node, path, apply_method = nil)
    nodes = node.xpath(path)
    if nodes.first
      value = nodes.first.content
      value = value.respond_to?(:strip) ? value.strip : value
      apply_method ? value.send(apply_method) : value
    end
  end

  def clean_amazon_url(str)
    unless str.index('%3F').nil?
      str[0..str.index('%3F') - 1]
    else
      str
    end
  end

end
