class JobController < ApplicationController

	layout "dashboard"

	def index
	    @enqueued_jobs = JobInfo.order(:run_at).all
	    @refresh_plan = DashboardJob.refresh_plan
	end

end
