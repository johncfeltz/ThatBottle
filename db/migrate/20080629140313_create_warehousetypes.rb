class CreateWarehousetypes < ActiveRecord::Migration
  def self.up
    create_table :warehousetypes do |t|
      t.column :whtype, :string
    end
  end

  def self.down
    drop_table :warehousetypes
  end
end
