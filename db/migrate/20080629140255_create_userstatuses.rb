class CreateUserstatuses < ActiveRecord::Migration
  def self.up
    create_table :userstatuses do |t|
      t.column :status, :string
    end
  end

  def self.down
    drop_table :userstatuses
  end
end
