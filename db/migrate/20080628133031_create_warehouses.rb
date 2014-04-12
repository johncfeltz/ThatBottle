class CreateWarehouses < ActiveRecord::Migration
  def self.up
    create_table :warehouses do |t|
      t.column :user_id, :integer
      t.column :warehousetype_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :warehouses
  end
end
