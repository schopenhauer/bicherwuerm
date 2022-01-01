ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  #include Warden::Test::Helpers
  #include Devise::Test::ControllerHelpers
  #Warden.test_mode!

  def login_as_user
    post user_session_path, "user[email]" => 'alice@wonderland.com', "user[password]" => 'password'
  end

  def login_as_admin
    post user_session_path, "user[email]" => 'admin@wonderland.com', "user[password]" => 'password'
  end

end
