class UpdateChartJob < Struct.new(:dashboard_name, :chart_name)

	include Rorschart::Helper

	def enqueue(job)
		if !(existing = already_in_queue? job.handler).nil?
			existing.delete
		end
	end

	def perform
		cache_key = UpdateChartJob.cache_key_for(dashboard_name, chart_name)
		
		begin
			data = call_chart_method_from_string(dashboard_name, chart_name)
			Rails.cache.write(cache_key, {status: :success, data: to_chart(data), last_update: DateTime.now})
		rescue Exception => e 
			Rails.cache.write(cache_key, {status: :error, message: e.message, last_update: DateTime.now})
		end
	end

	def self.cache_key_for(dashboard_name, chart_name)
		"#{dashboard_name}_job::#{chart_name}"
	end

private

	def call_chart_method_from_string(dashboard_name, chart_name)
		chart = "#{dashboard_name.camelize}Job".constantize.new
		chart.send(chart_name)
	end

	def already_in_queue?(handler)
	    Delayed::Job.where(['handler = ? and failed_at is null', handler]).first
  	end

end
