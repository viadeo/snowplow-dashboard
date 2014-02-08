namespace :redshift do
  
  namespace :sandbox do

    desc "Clean all events in the Sandbox database"
    task :clean => :environment do
      puts "Clean all Events in the Sandbox database..."
      SandboxEvent.delete_all
    end

    desc "Count events in the Sandbox database"
    task :count => :environment do
      puts "Counting events..."
      puts "#{SandboxEvent.count} events in the sandbox database"
    end

  end

  desc "Count events in the Redshift database"
  task :count => :environment do
    puts "Counting events..."
    puts "#{RedshiftEvent.count} events in the Redshift database"
  end

  desc "List all runnning queries in the Redshift database"  
  task :running_queries => :environment do
    sql = "select pid, trim(user_name), starttime, trim(query) from stv_recents where status='Running';"
    p RedshiftEvent.connection.exec_query(sql).to_hash
  end

  desc "Cancel all running queries in the Redshift database"  
  task :cancel_running_queries => :environment do
    running_pid = RedshiftEvent.connection.exec_query("select pid from stv_recents where status='Running';").to_hash
    running_pid.each { |pid|
      pid = pid["pid"]
      puts "Canceling query #{pid}..."
      RedshiftEvent.connection.exec_query("cancel #{pid};") 
    }
  end

  class SandboxEvent < ActiveRecord::Base
    self.table_name = "events"
    establish_connection(ENV['DATABASE_URL'])
  end

  class RedshiftEvent < ActiveRecord::Base
    self.table_name = "events"
    establish_connection(ENV['REDSHIFT_DATABASE_URL'])    
  end

end