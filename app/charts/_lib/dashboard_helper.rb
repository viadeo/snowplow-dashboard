module DashboardHelper

	def title (page_title, page_description)
		content_for :title, page_title.to_s
		content_for :description, page_description.to_s
	end

	def chart_info(last_update_time, refresh_policy)
		format_info_last_update(last_update_time) + " and will be refreshed " + format_info_refresh_policy(refresh_policy) + "."
	end

	def toolbar(dashboard, chart)
		render :partial => 'dashboard/dashboard_toolbar', :locals => {dashboard: dashboard, chart: chart}
	end



private

	def format_info_last_update(last_update_time)
		"Chart updated about <b>#{distance_of_time_in_words_to_now(last_update_time)}</b> ago".html_safe
	end

	def format_info_refresh_policy(refresh_policy)
		refresh_policy_str = distance_of_time_in_words(refresh_policy[:every]).gsub('about', '')
		str = "every <b>#{refresh_policy_str}</b>"
		str += " at <b>#{format_at(refresh_policy[:at])}</b>" if !refresh_policy[:at].blank?
		return str.html_safe
	end

	def format_at(at_hours_policy)
		if at_hours_policy.is_a? Enumerable
			at_hours_policy.join " and "
		else
			at_hours_policy.to_s
		end
	end

end
