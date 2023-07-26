source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.2.1'

gem 'rails', '~> 7.0.6'
gem 'psych'
gem 'importmap-rails'
gem 'dotenv-rails'
gem 'chartkick'
gem 'vacuum'
gem 'http'
gem 'devise'
gem 'domainatrix'
gem 'validates_formatting_of'
gem 'kaminari'
gem 'faker'
gem 'humanize_boolean'
gem 'filesize'
gem 'friendly_id'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'bootswatch-rails'
gem 'simple_form'
gem 'turbo-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'puma'
gem 'nio4r'
gem 'multi_json'
gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

source 'https://rails-assets.org' do
  gem 'rails-assets-highcharts'
  gem 'rails-assets-chartkick'
end

group :production do
  gem 'mysql2'
  # gem 'pg'
  gem 'sendgrid-actionmailer'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
  gem 'lol_dba'
  gem 'rack-mini-profiler'
  gem 'rubocop'
  gem 'seed_dump'
  gem 'seed-fu'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sqlite3'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
