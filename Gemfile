source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: [:development]

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


#
# Require gem for snowplow-dashboard
####################################

# Google Charts easly from ActiveRecord
gem "rorschart", github: 'viadeo/rorschart', :branch => 'master'

# Amazon Redshift adapter
gem 'activerecord4-redshift-adapter', github: 'aamine/activerecord4-redshift-adapter'

# Use Bootstrap for dashboard
gem 'bootstrap-sass-rails'

# Use Postgresql for local development
gem 'pg', group: :development

# Caching for chart
gem 'actionpack-action_caching'

# Use delayed_job for background processing
gem 'delayed_job_active_record'

# Web admin interface for delayed_job
gem 'delayed_job_web'

# Use clockwork to periodicly update chart in background
gem 'clockwork'

# Use forman explicitly
gem 'foreman', ">=0.63.0", group: :development

# Use rerun to restart worker jobs on change during development
gem 'rerun', group: :development

# User activerecord-import for bulk database import
gem 'activerecord-import', :require => false

# Support server side javascript on all environement
gem 'therubyracer'

group :production do

	# Use Heroku Memcache
	gem 'dalli'

	# Assets support for heroku deployment
	gem 'rails_12factor'

end
