class DashboardController < ApplicationController

	include Rorschart::Helper

	caches_action :chart

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

		chart = "#{dashboard_name.camelize}Dashboard".constantize.new
	  	render json: to_chart(chart.send(chart_name))
	rescue => e
		render :json => e.message, :status => 500
	end

end
