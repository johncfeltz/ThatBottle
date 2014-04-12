# Provide tasks to initalize the system
#  fixed enumerated data for the DB
#  initial user base

require 'active_record'
require 'active_record/fixtures'

namespace :db do
  DATA_DIRECTORY = "#{RAILS_ROOT}/lib/tasks/bootstrap"
  namespace :bootstrap do
    desc "Load enumerated data"
    task :enum_load => :environment do |t|
      class_name = nil    # Make Rails figure this out (pluralization...)
      TABLES = %w(winecolors winetypes graperoles acqtypes disptypes userstatuses warehousetypes valeventtypes)
      TABLES.each do |table_name|
        fixture = Fixtures.new(ActiveRecord::Base.connection,
                               table_name, class_name,
                               File.join(DATA_DIRECTORY, table_name.to_s))
        fixture.insert_fixtures
        puts "Loaded data from #{table_name}.yml"
      end
    end
    
    desc "Load admin data"
    task :admin_load => :environment do |t|
      class_name = nil
      TABLES = %w(users cellars profiles)
      TABLES.each do |table_name|
        fixture = Fixtures.new(ActiveRecord::Base.connection,
                              table_name, class_name,
                              File.join(DATA_DIRECTORY, table_name.to_s))
        fixture.insert_fixtures
        puts "Loaded data from #{table_name}.yml"
      end
    end
        
    desc "Remove enumerated data"
    task :enum_delete => :environment do |t|
      Winecolor.delete_all
      Winetype.delete_all
      Graperole.delete_all
      Valeventtype.delete_all
      Acqtype.delete_all
      Disptype.delete_all
      Userstatus.delete_all
      Warehousetype.delete_all
    end  
    
    desc "Remove admin data"
    task :admin_delete => :environment do |t|
      User.delete_all     # eventually use MIN_USER_NUMBER... 
      Cellar.delete_all
      Profile.delete_all
    end  
    
    desc "Load starter data for countries, apptypes, appellations, wines, grapes"
    task :starter_load => :environment do |t|
      class_name = nil
      TABLES = %w(grapes countries apptypes appellations wines)
      TABLES.each do |table_name|
        fixture = Fixtures.new(ActiveRecord::Base.connection,
                              table_name, class_name,
                              File.join(DATA_DIRECTORY, table_name.to_s))
        fixture.insert_fixtures
        puts "Loaded data from #{table_name}.yml"
      end
    end

    desc "Remove starter data"
    task :starter_delete => :environment do |t|
      Grape.delete_all
      Country.delete_all
      Apptype.delete_all
      Appellation.delete_all
      Wine.delete_all
    end
  end
end