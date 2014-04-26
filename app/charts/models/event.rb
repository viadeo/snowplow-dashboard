class Event < ActiveRecord::Base

	# Use heroky sandbox postgresql instance for speed-up development, or the real amazon redshift database if REDSHIFT_DATABASE_URL is present
	# REDSHIFT_DATABASE_URL must exist on heroku
	# heroku config:set DATABASE_URL="redshift://<redshit_user>:<redshift_password>@<amazon_redshift_host>:5439/snowplow?sslca=config/redshift-ssl-ca-cert.pem" -a <heroku_app_name>
	establish_connection(ENV['REDSHIFT_DATABASE_URL'] || "redshift_sandbox")


	default_scope	{ where("page_urlhost LIKE '%.viadeo.com'") }

	scope :group_by_date, 		-> { group('collector_tstamp::date') }
	scope :order_by_date, 		-> { order('collector_tstamp::date') }
	scope :select_date,   		-> { select('collector_tstamp::date as "Day"')}
	scope :count_visits, 		-> (as = "Visits") { select("count(distinct(domain_userid || domain_sessionidx)) as \"#{as}\"")}
	scope :count_visitors, 		-> (as = "Unique Visitors") { select("count(distinct(domain_userid)) as \"#{as}\"") }

	scope :count_logged_visits, 	-> { select('count(distinct(domain_userid || domain_sessionidx)) as "Logged Visits"').logged_users }
	scope :count_unlogged_visits, -> { select('count(distinct(domain_userid || domain_sessionidx)) as "Unlogged Visits"').unlogged_users }

	scope :count_logged_visitors, 	-> { select('count(distinct(domain_userid)) as "Logged Unique Visitors"').logged_users }
	scope :count_unlogged_visitors, -> { select('count(distinct(domain_userid)) as "Unlogged Unique Visitors"').unlogged_users }

	scope :unlogged_users,		-> { where('user_id IS NULL') }
	scope :logged_users,		-> { where('user_id IS NOT NULL') }


	scope :group_per_day,		-> { select_date.group_by_date.order_by_date }
	scope :during_last,			-> (days){ where(collector_tstamp: (Time.now.utc.midnight - days)..(Time.now.utc.midnight - 1.second)) }

	scope :landing_pages,		-> { where.not(refr_medium: "internal") }

	scope :geo_country, 		-> (country_code = :worldwide) { country_code == :worldwide ? all : where(geo_country: country_code.to_s.upcase)}

	def self.last_update
		unscoped.order(collector_tstamp: :desc).limit(1).pluck(:collector_tstamp).first
	end

	def self.from_sql(sql)
		find_by_sql(sql).to_a
	end

end
