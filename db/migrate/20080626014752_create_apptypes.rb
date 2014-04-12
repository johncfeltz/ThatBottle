class CreateApptypes < ActiveRecord::Migration
  def self.up
    create_table :apptypes do |t|
      t.column :abbrev, :string
      t.column :fullname, :string
      t.column :translation, :string
      t.column :notes, :text
      t.column :country_id, :integer
      t.column :nexthigher_id, :integer
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :apptypes
  end
end
