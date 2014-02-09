class Event < ActiveRecord::Base

	# Use local postgresql instance for speed-up development, or the real amazon redshift database if REDSHIFT_DATABASE_URL is present
	# REDSHIFT_DATABASE_URL must exist on heroku
	# heroku config:set DATABASE_URL="redshift://<redshit_user>:<redshift_password>@<amazon_redshift_host>:5439/snowplow?sslca=config/redshift-ssl-ca-cert.pem" -a <heroku_app_name>
	establish_connection(ENV['REDSHIFT_DATABASE_URL'] ||= Rails.env)

	scope :group_by_date, 		-> { group('collector_tstamp::date') }
	scope :order_by_date, 		-> { order('collector_tstamp::date') }
	scope :select_date,   		-> { select('collector_tstamp::date as "Day"')}
	
	scope :count_visits, 		-> { select('count(distinct(domain_userid || domain_sessionidx)) AS "Visits"')}
	scope :count_visitors, 		-> { select('count(distinct(domain_userid)) as "Unique Visitors"') }
	scope :group_per_day,		-> { select_date.group_by_date.order_by_date }

	scope :during_last,			-> (days){ where(collector_tstamp: (Time.now.midnight - days)..Time.now.midnight) }

	def self.last_update
		unscoped.order(collector_tstamp: :desc).limit(1).pluck(:collector_tstamp).first
	end

	def self.from_sql(sql)
		find_by_sql(sql).to_a
	end

end