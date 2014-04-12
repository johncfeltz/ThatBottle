class CreateWines < ActiveRecord::Migration
  def self.up
    create_table :wines do |t|
      t.column :name, :string
      t.column :notes, :text
      t.column :refs, :text
      t.column :producer, :string
      t.column :appellation_id, :integer
      t.column :winetype_id, :integer
      t.column :winecolor_id, :integer
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :wines
  end
end
