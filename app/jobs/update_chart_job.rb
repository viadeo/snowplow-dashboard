class UpdateChartJob < Struct.new(:dashboard_name, :chart_name)

	include Rorschart::Helper

	def perform
		cache_key = UpdateChartJob.cache_key_for(dashboard_name, chart_name)
		
		begin
			data = call_chart_method_from_string(dashboard_name, chart_name)
			Rails.cache.write(cache_key, {status: :success, data: to_chart(data)})
		rescue Exception => e 
			Rails.cache.write(cache_key, {status: :error, message: e.message})
		end
	end

	def self.cache_key_for(dashboard_name, chart_name)
		"#{dashboard_name}_dashboard::#{chart_name}"
	end

private

	def call_chart_method_from_string(dashboard_name, chart_name)
		chart = "#{dashboard_name.camelize}Dashboard".constantize.new
		chart.send(chart_name)
	end

end