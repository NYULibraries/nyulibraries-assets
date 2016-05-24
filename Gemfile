source 'https://rubygems.org'
gemspec
group :development, :test do
  gem 'coveralls', '~> 0.8.13', :require => false
  gem "pry", '~> 0.10.3'
  gem 'mustache-rails', github: 'NYULibraries/mustache-rails', tag: 'v0.2.3', require: 'mustache/railtie'
  gem "jquery-rails", '~> 3.1.4'

  platforms :jruby do
    gem 'therubyrhino', "~> 2.0.0"
    gem "activerecord-jdbcsqlite3-adapter", "~> 1.3.0"
    gem "mime-types", '2.99.1'
  end

  platforms :ruby do
    gem 'therubyracer', "~> 0.12.0"
    gem "sqlite3", "~> 1.3.7"
  end

  platforms :rbx do
    gem 'rubysl', '~> 2.0' # if using anything in the ruby standard library
    gem 'json', '~> 1.8.1'
    gem 'rubinius-coverage'
    gem 'rubysl-test-unit'
    gem "racc"
  end
end
