class CreateGraperoles < ActiveRecord::Migration
  def self.up
    create_table :graperoles do |t|
      t.column :role, :string
    end
  end

  def self.down
    drop_table :graperoles
  end
end
