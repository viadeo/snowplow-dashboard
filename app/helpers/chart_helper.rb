module ChartHelper

	## Wrapper of Rorschart

	def area_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

	def line_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

	def pie_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

	def column_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

	def bar_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

	def table_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

	def geo_chart(dashboard, chart, options = {})
		toolbar(dashboard, chart) + super(chart_data_path(dashboard, chart), options)
	end

end
