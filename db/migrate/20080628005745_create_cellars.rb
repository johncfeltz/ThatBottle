class CreateCellars < ActiveRecord::Migration
  def self.up
    create_table :cellars do |t|
      t.column :user_id, :integer
      t.column :topbottlenumber, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :cellars
  end
end
