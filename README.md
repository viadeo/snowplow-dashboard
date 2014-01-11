# Snowplow-dashboard

Snowplow-dashboard that lets you build beautiful dashboards over your Snowplow Redshift Database, in one line of Ruby. Based on [Rorschart](https://github.com/viadeo/rorschart).

```ruby
<%= pie_chart Event.group(:br_family).count %>
```

![Browser Technologies](sample-pie.png?raw=true)

Hot !

### Group Charts in beautiful dashboards

![Basic Dashboard](sample.png?raw=true "Optional title")


## License

Distributed under the MIT license.