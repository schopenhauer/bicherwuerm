ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as_user
    post user_session_path, "user[email]" => 'alice@wonderland.com', "user[password]" => 'password'
  end

  def login_as_admin
    post user_session_path, "user[email]" => 'admin@wonderland.com', "user[password]" => 'password'
  end

end
