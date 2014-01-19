class DashboardController < ApplicationController

	include Rorschart::Helper

	def index
	end

	def show
		dashboard_name = params[:dashboard_name]

	  	if template_exists?(dashboard_name, "dashboard")
			render dashboard_name
		else
			render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    	end
	end

	def chart
		dashboard_name = params[:dashboard_name]
		chart_name = params[:chart_name]

		cache_key = UpdateChartJob.cache_key_for(dashboard_name, chart_name)
		cached_data = Rails.cache.fetch(cache_key)

		if (cached_data.blank?)
			Rails.cache.write(cache_key, :processing)
			Delayed::Job.enqueue UpdateChartJob.new(dashboard_name, chart_name)
			render :json => "Background Processing. Please refresh manualy. Polling not yet implemented.".to_json, :status => 202
	  	elsif (cached_data == :processing)
	  		render :json => "Still processing...".to_json, :status => 202
	  	else
	  		render json: cached_data
	  	end

	rescue => e
		render :json => e.message, :status => 500
	end

end
