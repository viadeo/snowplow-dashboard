  class SandboxEvent < ActiveRecord::Base
    self.table_name = "events"
    establish_connection(ENV['DATABASE_URL'])
  end