  class SandboxEvent < ActiveRecord::Base
    self.table_name = "atomic.events"
    establish_connection(ENV['SANDBOX_DATABASE_URL'] || "redshift_sandbox")
  end
