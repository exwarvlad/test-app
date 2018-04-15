source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.5'

gem 'hashie', '~> 3.4.0'
gem 'kaminari', '~> 1.1.1'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'

group :development, :test do
  gem 'bullet', '5.6.1'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'faker', '~> 1.8.5'
  gem 'rspec-rails', '~> 3.6'
  gem 'activerecord-import', github: 'zdennis/activerecord-import'
end

group :test do
  gem 'database_cleaner', '~> 1.6.2'
end

group :development do
  gem 'listen', '~> 3.1.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :pry do
  gem 'awesome_print', '1.8.0'
  gem 'byebug', '9.1.0'
  gem 'pry', '0.11.2'
  gem 'pry-byebug', '3.5.0'
  gem 'pry-doc', '0.11.1'
  gem 'pry-rails', '0.3.6'
end
