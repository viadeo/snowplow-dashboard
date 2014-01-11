# Snowplow-dashboard

Snowplow-dashboard that lets you build beautiful dashboards over your Snowplow Redshift Database, in one line of Ruby. Based on [Rorschart](https://github.com/viadeo/rorschart).

```ruby
<%= pie_chart Event.group(:br_family).count %>
```

![Browser Technologies](sample-pie.png?raw=true)

Hot !

### Group Charts in beautiful dashboards

![Basic Dashboard](sample.png?raw=true "Optional title")

### Use out-of-the-box Snowplow Recipes

Snowplow provides dozen common [Web analytics recipes](http://snowplowanalytics.com/analytics/basic-recipes.html).

Just call them and your appropriate chart representation.

```ruby
line_chart RecipesBasic.pages_per_visit
table_chart RecipesBasic.behavior_frequency
pie_chart RecipesBasic.technology_browser
line_chart RecipesBasic.uniques_and_visits_by_day
```

### Build your custom query

```ruby
Event.group_per_day.count_visitors.where(page_urlpath: "/step/profile").during_last 30.days
```

### And many more

Features to document:
* Build your analytics DSL
* A/B testing
* Asynchronous Ajax loading
* Caching
* Heroku ready
* Queries from raw SQL

## License

Distributed under the MIT license.