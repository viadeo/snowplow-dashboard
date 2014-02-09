class RecipesBasicDashboard < ChartDashboard

	refresh :default, every: 1.week, at: 'Sunday 22:42'
	
	refresh :uniques_and_visits_by_day, :pageviews_by_day, :bounce_rate_by_day, :avg_visit_duration_by_day, :new_vs_returning, every: 1.day, at: ['13:00', '06:00']

	def pages_per_visit
		Event.from_sql("select * from recipes_basic.pages_per_visit")
	end

	def behavior_frequency 
		Event.from_sql("select * from recipes_basic.behavior_frequency")
	end

	def behavior_recency 
		Event.from_sql("select * from recipes_basic.behavior_recency")
	end

	def bounce_rate_by_day 
		Event.from_sql("select * from recipes_basic.bounce_rate_by_day")
	end
	
	def engagement_pageviews_per_visit 
		Event.from_sql("select * from recipes_basic.engagement_pageviews_per_visit")
	end
	
	def avg_visit_duration_by_day 
		Event.from_sql("select * from recipes_basic.avg_visit_duration_by_day")
	end
	
	def engagement_visit_duration 
		Event.from_sql("select * from recipes_basic.engagement_visit_duration")
	end
	
	def events_by_day 
		Event.from_sql("select * from recipes_basic.events_by_day")
	end
	
	def fraction_new_visits_by_day 
		Event.from_sql("select * from recipes_basic.fraction_new_visits_by_day")
	end
	
	def new_vs_returning 
		Event.from_sql("select * from recipes_basic.new_vs_returning")
	end
	
	def pages_per_visit 
		Event.from_sql("select * from recipes_basic.pages_per_visit")
	end
	
	def pageviews_by_day 
		Event.from_sql("select * from recipes_basic.pageviews_by_day")
	end
	
	def technology_browser 
		Event.from_sql("select * from recipes_basic.technology_browser")
	end
	
	def technology_mobile 
		Event.from_sql("select * from recipes_basic.technology_mobile")
	end
	
	def technology_os 
		Event.from_sql("select * from recipes_basic.technology_os")
	end
	
	def uniques_and_visits_by_day 
		Event.from_sql("select * from recipes_basic.uniques_and_visits_by_day")
	end
	
	def visitors_by_language 
		Event.from_sql("select * from recipes_basic.visitors_by_language")
	end
	
	def visits_by_country 
		Event.from_sql("select * from recipes_basic.visits_by_country")
	end

end