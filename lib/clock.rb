require 'clockwork'

# require boot & environment for a Rails app
require_relative "../config/boot"
require_relative "../config/environment"

module Clockwork

  # Load dashboards definition
  charts_path = Rails.root.join('app', 'models', 'charts',)
  Dir[File.join(charts_path, '**', '/*_dashboard.rb')].each { |chart|
    require(chart)
  }

  # Roughly print refresh plan
  puts ChartDashboard.refresh_plan

  # Add a clock for each defined refresh
  ChartDashboard.refresh_plan.each { |dashboard|
    dashboard_name = dashboard[0].underscore.gsub('_dashboard', '')
    dashboard[1].each { |chart|
      chart_name = chart[0]
      options = chart[1]

      every(options[:every], "#{dashboard_name}.#{chart_name}", options) do
        Delayed::Job.enqueue UpdateChartJob.new(dashboard_name, chart_name)
      end
    }
  }

end