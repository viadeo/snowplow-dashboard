class UpdateChartJob < Struct.new(:dashboard_name, :chart_name)

	def perform
		# to implement: custom cache expiration management by chart
		Rails.cache.fetch(UpdateChartJob.cache_key_for(dashboard_name, chart_name), :expires_in => 1.hour) do
			call_chart_method_from_string(dashboard_name, chart_name)
		end
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