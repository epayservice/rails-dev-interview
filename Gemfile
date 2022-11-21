source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i{mingw mswin x64_mingw jruby}
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i{mri mingw x64_mingw}
end

group :development do
  gem "web-console"
  gem "spring"
  gem "annotate"
  gem "sinatra", require: false
end

