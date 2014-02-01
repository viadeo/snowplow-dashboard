class DashboardController < ApplicationController

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

end
