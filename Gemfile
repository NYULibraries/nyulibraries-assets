source 'https://rubygems.org'
gemspec
group :development, :test do
  gem 'coveralls', :require => false
  gem "pry"

  platforms :jruby do
    gem 'therubyrhino', "~> 2.0.0"
    gem "activerecord-jdbcsqlite3-adapter", "~> 1.3.0"
  end

  platforms :ruby do
    gem 'therubyracer', "~> 0.12.0"
    gem "sqlite3", "~> 1.3.7"
  end

  platforms :mri do
    gem "debugger", "~> 1.6.0"
  end

  platforms :rbx do
    gem 'rubysl', '~> 2.0' # if using anything in the ruby standard library
    gem 'json', '~> 1.8.1'
    gem 'rubinius-coverage'
    gem 'rubysl-test-unit'
    gem "racc"
  end
end
