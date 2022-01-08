source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'rails', '~> 7.0'
gem 'bootsnap', '>= 1.4.2'
gem 'bundler', '~> 2'
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
gem 'sass-rails', '~> 6'
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'bootswatch-rails'
gem 'simple_form'
gem 'autoprefixer-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'puma'
gem 'multi_json'
gem 'rating'

source 'https://rails-assets.org' do
  gem 'rails-assets-highcharts'
  gem 'rails-assets-chartkick'
end

group :development, :test do
  gem 'byebug'
  gem 'lol_dba'
  gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'rubocop'
  gem 'listen'
  gem 'seed_dump'
  gem 'seed-fu', '~> 2.3'
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sqlite3', '~> 1.4'
  gem 'rspec'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :production do
  gem 'mysql2'
  gem 'mini_racer'
  # gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
