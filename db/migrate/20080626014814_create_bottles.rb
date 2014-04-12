class CreateBottles < ActiveRecord::Migration
  def self.up
    create_table :bottles do |t|
      t.column :cellar_id, :integer
      t.column :cellarnum, :integer
      t.column :cellarlabel, :text
      t.column :cellarlocation, :text
      t.column :vintage, :integer
      t.column :bottlesize, :float
      t.column :wine_id, :integer
      t.column :alcohol, :float
      t.column :acquisition_id, :integer
      t.column :disptype_id, :integer
      t.column :notes, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :bottles
  end
end
