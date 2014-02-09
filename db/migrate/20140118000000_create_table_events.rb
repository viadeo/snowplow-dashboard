class CreateTableEvents < ActiveRecord::Migration
 def up
	atomic_def_sql = File.read("./db/snowplow_sql/atomic-def.sql")    
	execute atomic_def_sql
  end

  def down
  	execute <<-SQL
      DROP SCHEMA "atomic" CASCADE;
    SQL
  end
end
