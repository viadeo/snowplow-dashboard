namespace :redshift do

  require "redshift_event" if ENV['REDSHIFT_DATABASE_URL']
  require "sandbox_event" if ENV['DATABASE_URL']
  
  # use activerecord-import for bulk import in postgres, but only for the Sandbox adapter
  require "activerecord-import/base"
  ActiveRecord::Import.require_adapter('postgresql')

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

    desc "Update Sandbox from Redshift about 500-1500 events per day for last 7 days"
    task :update => :environment do
      puts "Counting events before Sandbox update..."
      puts "#{SandboxEvent.count} events in Sandbox"

      puts "Transfering events for last 10 days from Redshift to Sandbox (Can takes several minutes)..."
      (Date.today - 10.day..Date.today).each do |date|

        random_events_count = Random.new.rand 500..1500

        print "Retrieving #{random_events_count} events from Redshift for #{date}..."
        events = RedshiftEvent.where(collector_tstamp: (date.to_datetime)..date.to_datetime + 1.day).limit(random_events_count).collect { |e|
          SandboxEvent.new(e.attributes)
        }
        puts " Done."; print "Saving Events to Sandbox..."
        SandboxEvent.import events
        puts " Done."
      end

      puts "Done."
      puts "Counting events after Sandbox update..."
      puts "#{SandboxEvent.count} events in Sandbox"
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