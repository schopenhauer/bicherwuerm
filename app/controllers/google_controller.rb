class GoogleController < ApplicationController
  before_action :authenticate_user!
  before_action :valid_google_credentials?

  def search
    if valid_google_credentials?
      @images = params[:q] ? query(params[:q]) : nil
      render 'google/search'
    else
      render 'google/credentials'
    end
  end

  private

  def valid_google_credentials?
    APP_CONFIG['google_client_cx'] && APP_CONFIG['google_client_key']
  end

  def query(query, safe_search = :off)
    query_params = {
      v: '1.0',
      searchType: 'image',
      q: query,
      safe: safe_search,
      fields: 'items',
      rsz: 8,
      cx: APP_CONFIG['google_client_cx'],
      key: APP_CONFIG['google_client_key']
    }

    http_response = HTTP.get(
      'https://www.googleapis.com/customsearch/v1',
      params: query_params
    )
    data = MultiJson.load(http_response.body)

    if http_response.status == 200
      @images = data['items'] if data['items']
    else
      @images = nil
    end
  end

end
