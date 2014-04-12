class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.column :name, :string
      t.column :isocode_num, :string
      t.column :isocode_2let, :string
      t.column :isocode_3let, :string
      t.column :notes, :text
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
