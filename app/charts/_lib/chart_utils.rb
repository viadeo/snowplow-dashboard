class JobUtils

  def self.convertion_rate(series = { base_serie: [], converted_serie:[], label:nil })
    converted_series_by_date = {}

    converted_serie_label = series[:converted_serie].first.attributes.keys[1]
    base_serie_label = series[:base_serie].first.attributes.keys[1]
    rate_name = series[:label] ||= "#{converted_serie_label} / #{base_serie_label}"
 
    series[:converted_serie].each { |e|
      a = e.attributes.values
      converted_series_by_date[a[0]] = a[1]
    }

    series[:base_serie].collect { |e|      

      day = e.attributes.values[0]
      visits = e.attributes.values[1]
      converted = converted_series_by_date[day]

      { "day" => day, rate_name => converted ? (converted * 100.0 / visits) : nil}
    }
  end

end