class CreateWinecolors < ActiveRecord::Migration
  def self.up
    create_table :winecolors do |t|
      t.column :winecolor, :string
    end
  end

  def self.down
    drop_table :winecolors
  end
end
