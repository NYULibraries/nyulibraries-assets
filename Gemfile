source 'https://rubygems.org'
gemspec
group :development, :test do
  # Add rake dependency for tests
  gem "rake"

  platforms :jruby do
    gem 'therubyrhino'
  end

  platforms :ruby do
    gem 'therubyracer', "~> 0.10.0"
  end
end
