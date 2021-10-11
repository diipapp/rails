source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

# Core
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'http_accept_language'
gem "bullet"

# Security
gem 'bcrypt', '~> 3.1.7'
gem 'gemsurance'
gem 'omniauth-rails_csrf_protection', '~> 0.1'
gem 'rack-attack'

# Monitoring
gem 'airbrake-ruby'

# Backend
gem 'omniauth', '1.9.1'
gem 'devise', git: "https://github.com/heartcombo/devise.git",  branch: "ca-omniauth-2"
gem 'omniauth-google-oauth2' # https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284
gem 'omniauth-facebook'
gem 'simple_form'
gem 'sixarm_ruby_unaccent'
gem 'metainspector'
gem 'sendgrid-ruby'
gem 'apexcharts'
gem "punching_bag"
gem 'httparty'

# Frontend
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem "better_errors"
  gem "binding_of_caller"  
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'faker', '~> 2.14'
