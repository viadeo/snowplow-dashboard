module DashboardHelper

	def title (page_title, page_description)
		content_for :title, page_title.to_s
		content_for :description, page_description.to_s
	end

	def chart_info_tooltip(dashboard, chart)
		chart_info_url = chart_info_path(:welcome, :events_count_per_day)
		title = chart.to_s.titleize
		"<i class='glyphicon glyphicon-info-sign' rel='tooltip' data-title='#{title}' data-info-url='#{chart_info_url}'></i>".html_safe
	end

	def format_info_last_update(last_update_time)
		"Chart updated about <b>#{distance_of_time_in_words_to_now(last_update_time)}</b> ago".html_safe
	end
end
