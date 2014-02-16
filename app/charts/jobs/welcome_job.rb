class WelcomeJob < DashboardJob

	refresh :last_event_date, every: 10.minutes
	refresh :events_count_per_day, every: 1.hour


	def last_event_date
		{ "Last event in RedShift: " => Event.last_update }
	end

	def events_count_per_day
		Event.from_sql("select collector_tstamp::date, count(*) from events group by 1 order by 1;")
	end

end