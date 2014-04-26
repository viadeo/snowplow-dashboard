namespace :redshift do

  require "redshift_event" if ENV['REDSHIFT_DATABASE_URL']
  require "sandbox_event" if ENV['DATABASE_URL']
  
  # use activerecord-import for bulk import in postgres, but only for the Sandbox adapter
  require "activerecord-import/base"
  ActiveRecord::Import.require_adapter('postgresql')

  namespace :sandbox do

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

end