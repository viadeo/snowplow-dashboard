class Event < ActiveRecord::Base

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