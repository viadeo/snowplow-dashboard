class CreateJobStats < ActiveRecord::Migration
  def change
    create_table :job_stats do |t|
      t.string :dashboard
      t.string :chart
      t.datetime :started_at
      t.integer :duration, :limit => 8
	  t.integer :waiting_duration, :integer, :limit => 8
      t.timestamps
    end
    add_index :job_stats, [:dashboard, :chart]
    add_index :job_stats, [:started_at]    
  end
end
