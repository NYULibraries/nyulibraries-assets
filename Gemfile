source 'https://rubygems.org'
gemspec
group :development, :test do
  gem 'coveralls', :require => false
  platforms :jruby do
    gem 'therubyrhino', "~> 2.0.0"
  end

  platforms :ruby do
    gem 'therubyracer', "~> 0.10.0"
  end
end
