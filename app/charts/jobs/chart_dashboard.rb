class ChartDashboard

	#This implementation deeply sucks. Need a refactoring to support :refresh definition with shared static hash.

    @@refresh_plan = {}

    def self.refresh(*actions)
      options = actions.extract_options!
      charts = actions
      @@refresh_plan[self.name] ||= {}

      @@refresh_plan[self.name].merge!(Hash[charts.collect{ |chart|
        [chart, options]
      }])
    end

    def self.refresh_plan
      
      @@refresh_plan.each { |dashboard|
        dashboard_class = dashboard[0]
        charts = dashboard[1]
        if charts.key?(:default)
          default_options = charts[:default]
          all_charts_with_default_options = define_default_for_all_charts(dashboard_class, default_options).merge(charts)
          charts.merge!(all_charts_with_default_options).except!(:default)
        end
      }

      @@refresh_plan
    end

    def self.refresh_policy_for_chart(dashboard_name, chart_name)
      chart_class_name = "#{dashboard_name.camelize}Dashboard".constantize
      chart_class_name.refresh_plan[chart_class_name.name][chart_name.to_sym]
    end

  private

    def self.define_default_for_all_charts(dashboard_class, default_options)
      Hash[dashboard_class.constantize.instance_methods(false).collect { |chart|
        [chart, default_options]
      }]
    end    

end