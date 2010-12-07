source 'http://rubygems.org'

gem 'rails', '3.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

if defined?(JRUBY_VERSION)
    # gem 'jdbc-sqlite3'
    gem 'activerecord-jdbc-adapter'
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbcmssql-adapter'
    gem 'jruby-openssl'
    gem 'jruby-rack'
    # gem 'warbler'

    # gem 'jruby-memcache-client'
else
    gem 'sqlite3-ruby', :require => 'sqlite3'
end

#gem 'devise'
#gem 'cancan'
gem 'haml'
gem 'will_paginate',        '>= 3.0.pre2'

# gem "simple-navigation"

# format log
gem 'awesome_print',      '>= 0.2.1'

group :development do
   gem 'annotate',           '>= 2.4.0'
   gem 'ffaker',             '>= 0.4.0' # Fast Faker for `rake crm:demo:load`
   gem 'rails3-generators'
   gem 'warbler'
end

gem 'yaml_db'
gem 'uuidtools'
gem 'fastercsv'

gem 'dalli'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
