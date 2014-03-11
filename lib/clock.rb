require 'clockwork'

# require boot & environment for a Rails app
require_relative "../config/boot"
require_relative "../config/environment"

module Clockwork

  # Load dashboards definition
  charts_path = Rails.root.join('app', 'charts', 'jobs')
  Dir[File.join(charts_path, '**', '/*_job.rb')].each { |chart|
    require(chart)
  }

  # Roughly print refresh plan
  puts DashboardJob.refresh_plan

  # Add a clock for each defined refresh
  DashboardJob.refresh_plan.each { |dashboard|
    dashboard_name = dashboard[0].underscore.gsub('_job', '')
    dashboard[1].each { |chart|
      chart_name = chart[0]
      options = chart[1]

      every(options[:every], "#{dashboard_name}.#{chart_name}", options) do
        Delayed::Job.enqueue UpdateChartJob.new(dashboard_name, chart_name)
      end
    }
  }

end
