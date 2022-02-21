# frozen_string_literal: true

source "https://rubygems.org"

gem 'sinatra'
gem 'sinatra-contrib'
gem 'pg'

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'capybara'
end

group :development, :test do
  gem 'rubocop', '1.20'
end