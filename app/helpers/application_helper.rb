module ApplicationHelper

  def full_title(page_title = '')
    if page_title.empty?
      APP_CONFIG['application_name']
    else
      "#{APP_CONFIG['application_name']} » #{page_title}"
    end
  end

  def clean_url(link = '', remove_path = true)
    if remove_path
      # Remove HTTP and HTTPS (as well as path?)
      link.gsub(%r{/^https?\:\/\/(www.)?/}, '').sub(%r{/\/.*$/}, '')
    else
      link.gsub(%r{/^https?\:\/\//}, '').sub(%r{/^www./}, '')
    end
  end

  def safe_timestamp(timestamp)
    if timestamp.nil?
      'n.a.'
    else
      timestamp.strftime(APP_CONFIG['date_time_format'])
    end
  end

  def pretty_timestamp(obj, name)
    content_tag(:p) { "This #{name} was added on #{safe_timestamp(obj.created_at)} and last updated on #{safe_timestamp(obj.updated_at)}." }
  end

  def search_path(controller)
    case controller
    when 'books'
      books_path
    when 'publishers'
      publishers_path
    when 'genres'
      genres_path
    else
      books_path
    end
  end

  def is_active_controller?(controller)
    ' class="active"'.html_safe if params[:controller] == controller
  end

  def is_active_action?(action)
    ' class="active"'.html_safe if params[:action] == action
  end

  def is_active_action_and_controller?(action, controller)
    is_active_action?(action) && is_active_controller?(controller)
  end

end
