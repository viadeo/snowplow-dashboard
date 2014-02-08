namespace :redshift do

  require "redshift_event" if ENV['REDSHIFT_DATABASE_URL']
  require "sandbox_event" if ENV['DATABASE_URL']
  
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

    desc "Update Sandbox from Redshift with 1000 events per day for last 7 days"
    task :update => :environment do
      puts "Counting events before Sandbox update..."
      puts "#{SandboxEvent.count} events in Sandbox"
      puts "#{RedshiftEvent.count} events in Redshift"

      print "Transfering 1000 events from yesterday..."
      
      RedshiftEvent.where(collector_tstamp: (Time.now.midnight - 1.day)..Time.now.midnight).limit(1000).each { |event|
        SandboxEvent.new(event.attributes).save
      }

      puts "Done."

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