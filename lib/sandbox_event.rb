  class SandboxEvent < ActiveRecord::Base
    self.table_name = "atomic.events"
    establish_connection("redshift_sandbox")
  end