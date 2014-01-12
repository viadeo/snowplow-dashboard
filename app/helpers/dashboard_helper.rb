module DashboardHelper

	def title (page_title, page_description)
		content_for :title, page_title.to_s
		content_for :description, page_description.to_s
	end

end
