class JobInfo < ActiveRecord::Base
	
	include ActionView::Helpers::DateHelper

	self.table_name = "delayed_jobs"

	def dashboard_name
		handler_infos[3]
	end

	def chart_name
		handler_infos[5]
	end

	def status
		return :running if !locked_at.nil?
		return :failed if !last_error.nil?
		return :waiting
	end

	def status_with_duration
		return "Waiting for #{distance_of_time_in_words_to_now(run_at)}" if status == :waiting
		return "Running for #{distance_of_time_in_words_to_now(locked_at, include_seconds: true)}" if status == :running
	end

private

	def handler_infos
		@handler_infos ||= handler.split(" ")
	end


end