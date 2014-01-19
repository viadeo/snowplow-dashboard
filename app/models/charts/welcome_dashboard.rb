class WelcomeDashboard < ChartDashboard

	refresh :events_count_per_day, every: 1.hour

	def events_count_per_day
		Event.from_sql("select collector_tstamp::date, count(*) from events group by 1 order by 1;")
	end

end