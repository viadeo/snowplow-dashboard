# Use a dedicated database for delay_job to prevent using the redshift instance in production

Delayed::Job.class_eval do
  establish_connection ActiveRecord::Base.configurations["#{Rails.env}"]
end