class CreateWinetypes < ActiveRecord::Migration
  def self.up
    create_table :winetypes do |t|
      t.column :winetype, :string
    end
  end

  def self.down
    drop_table :winetypes
  end
end
