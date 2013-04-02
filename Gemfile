source 'https://rubygems.org'
gemspec
group :development, :test do
  gem 'coveralls', :require => false
  platforms :jruby do
    gem 'therubyrhino', "~> 2.0.0"
    gem "activerecord-jdbcsqlite3-adapter", "~> 1.2.9"
  end

  platforms :ruby do
    gem 'therubyracer', "~> 0.11.0"
    gem "sqlite3", "~> 1.3.7"
  end
end
