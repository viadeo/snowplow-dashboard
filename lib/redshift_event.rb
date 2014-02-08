  class RedshiftEvent < ActiveRecord::Base
    self.table_name = "events"
    establish_connection(ENV['REDSHIFT_DATABASE_URL'])
  end