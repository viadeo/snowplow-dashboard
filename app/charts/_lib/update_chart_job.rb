class Time
  def to_ms
    (self.to_f * 1000.0).to_i
  end
end

class UpdateChartJob < Struct.new(:dashboard_name, :chart_name)

	include Rorschart::Helper
	include ActionView::Helpers::DateHelper	

	def enqueue(job)
		if !(existing = already_in_queue? job.handler).nil?
			existing.delete
		end
	end

	def before(job)
		@job_starttime = Time.now
	end

	def after(job)
		running_duration = ((Time.now - @job_starttime).to_f * 1000.0).to_i
		waiting_duration = ((@job_starttime - job.run_at).to_f * 1000.0).to_i
		JobStat.create(dashboard: dashboard_name, chart: chart_name, started_at: job.run_at, duration: running_duration, waiting_duration: waiting_duration)
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
