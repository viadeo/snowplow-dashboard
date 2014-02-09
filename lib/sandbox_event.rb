  class SandboxEvent < ActiveRecord::Base
    self.table_name = "atomic.events"
    establish_connection(ENV['DATABASE_URL'])
  end