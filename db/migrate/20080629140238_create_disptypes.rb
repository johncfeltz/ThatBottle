class CreateDisptypes < ActiveRecord::Migration
  def self.up
    create_table :disptypes do |t|
      t.column :disptype, :string
    end
  end

  def self.down
    drop_table :disptypes
  end
end
