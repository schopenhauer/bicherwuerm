module ApplicationHelper

  def full_title(title = '')
    APP_CONFIG['application_name'] + " » #{title}" unless title.empty?
  end

  def clean_url(url)
    Domainatrix.parse(url).url
  end

  def short_url(url)
    url.sub(/^https?\:\/\/(www.)?/,'').chomp('/')
  end

  def timestamp(timestamp)
    if timestamp.nil?
      'n.a.'
    else
      timestamp.strftime(APP_CONFIG['date_time_format'])
    end
  end

  def pretty_timestamp(obj, name)
    content_tag(:p) { "This #{name} was added on #{timestamp(obj.created_at)} and last updated on #{timestamp(obj.updated_at)}." }
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
