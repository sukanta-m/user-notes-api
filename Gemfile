source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise-jwt'
gem 'fast_jsonapi'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'acts-as-taggable-on', '~> 6.0'
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  gem "faker", "~> 2.11"
  gem "pry-rails", "~> 0.3.9"
  gem "rspec-rails", "~> 4.0"
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop', '~> 0.90.0'
  gem "rubocop-performance", "~> 1.5", ">= 1.5.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem "database_cleaner", "~> 1.8", ">= 1.8.3"
  gem "factory_bot_rails", "~> 5.1", ">= 5.1.1"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.4"
  gem "shoulda-callback-matchers", "~> 1.1", ">= 1.1.4"
  gem "shoulda-matchers", "~> 4.3"
  gem "simplecov", "~> 0.18.5"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
