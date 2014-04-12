class CreateGrapes < ActiveRecord::Migration
  def self.up
    create_table :grapes do |t|
      t.column :name, :string
      t.column :notes, :text
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :grapes
  end
end
