# Snowplow-dashboard

Snowplow-dashboard that lets you build beautiful dashboards over your [Snowplow](http://snowplowanalytics.com) Redshift Database, in one line of Ruby. Based on [Rorschart](https://github.com/viadeo/rorschart).

```ruby
<%= pie_chart Event.group(:br_family).count %>
```

![Browser Technologies](sample-pie.png?raw=true)

Hot !

## Getting Started
* [Setup guide for local development](https://github.com/viadeo/snowplow-dashboard/wiki/Installation-guide-for-local-development)
* [Develop your first analytic dashboard in less than 5 min](https://github.com/viadeo/snowplow-dashboard/wiki/Develop-your-first-analytic-dashboard-in-less-than-5-min)


## Overview

### Group Charts in beautiful dashboards

Example using Haml and Bootstrap
```haml
.row
    %h3 Bounce rate by day
    = line_chart RecipesBasic.bounce_rate_by_day
.row
    .col-md-6
        %h3 Avg Visit Duration by day
        = column_chart RecipesBasic.avg_visit_duration_by_day
    .col-md-6
        %h3 Engagement Visit duration
        = pie_chart RecipesBasic.engagement_visit_duration
```

![Basic Dashboard](sample-dashboard.png?raw=true)

### Use out-of-the-box Snowplow Recipes

Snowplow provides dozen of standard [Web analytics recipes](http://snowplowanalytics.com/analytics/basic-recipes.html).

We provide three Models `RecipesBasic`, `RecipesCustomer`, `RecipesCatalog`. Just call the method that you want, and choose the appropriate chart representation.

```ruby
line_chart RecipesBasic.pages_per_visit
table_chart RecipesBasic.behavior_frequency
pie_chart RecipesBasic.technology_browser
line_chart RecipesBasic.uniques_and_visits_by_day
```

### Build your custom queries

```ruby
Event.group_per_day.count_visitors.where(page_urlpath: "/step/profile").during_last 30.days
```

### And many more

Features to document:
* Queries from raw SQL
* Queries from your organization Analytics DSL
* Asynchronous Ajax loading
* Caching
* Heroku ready
* A/B testing Methodology

## License

Distributed under the MIT license.
