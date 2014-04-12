class CreateValeventtypes < ActiveRecord::Migration
  def self.up
    create_table :valeventtypes do |t|
      t.column :eventtype, :string
    end
  end

  def self.down
    drop_table :valeventtypes
  end
end
