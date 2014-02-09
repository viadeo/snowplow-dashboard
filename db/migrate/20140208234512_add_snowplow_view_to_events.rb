class AddSnowplowViewToEvents < ActiveRecord::Migration
 def up
 	recipes_basic_sql = File.read("./db/snowplow_sql/recipes-basic.sql")    
    execute recipes_basic_sql
  end

  def down
  	execute <<-SQL
      DROP SCHEMA "recipes_basic" CASCADE;
    SQL
  end
end
