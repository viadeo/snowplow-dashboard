class ChartController < ApplicationController

	before_action :retrieve_chart_params

	def show
		if @cached_chart.blank?
			Rails.cache.write(@cache_key, {:status => :processing})
			Delayed::Job.enqueue UpdateChartJob.new(@dashboard_name, @chart_name)
			render json: "Background Processing. Please refresh manualy. Polling not yet implemented.".to_json, status: 202
		else
			case @cached_chart[:status]
			when :processing
				render json: "Still processing...".to_json, status: 202
			when :success
				render json: @cached_chart[:data]
			when :error
				Rails.cache.delete(@cache_key)
				render json: @cached_chart[:message], status: 500
		  	end
	  	end
	rescue => e
		render json: e.message, status: 500
	end

	def info
		render json: ApplicationController.helpers.chart_info(@cached_chart[:last_update], ChartDashboard.refresh_policy_for_chart(@dashboard_name, @chart_name)).to_json
	end

	def clear_cache
		Rails.cache.delete(@cache_key)		
		render :nothing => true
	end

	private

	def retrieve_chart_params
		@dashboard_name = params[:dashboard_name]
		@chart_name = params[:chart_name]
		@cache_key = UpdateChartJob.cache_key_for(@dashboard_name, @chart_name)
		@cached_chart = Rails.cache.fetch(@cache_key)		
	end

end
