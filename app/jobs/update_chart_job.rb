class UpdateChartJob < Struct.new(:dashboard_name, :chart_name)

	def perform
		puts "sleep... long job"
		sleep 5
		puts "ok."

		cache_key = UpdateChartJob.cache_key_for(dashboard_name, chart_name)
		data = call_chart_method_from_string(dashboard_name, chart_name)

		# to implement: custom cache expiration management by chart
		Rails.cache.write(cache_key, data)
	end

	def self.cache_key_for(dashboard_name, chart_name)
		"#{dashboard_name}_dashboard::chart_name"
	end

private

	def call_chart_method_from_string(dashboard_name, chart_name)
		chart = "#{dashboard_name.camelize}Dashboard".constantize.new
		chart.send(chart_name)
	end

end