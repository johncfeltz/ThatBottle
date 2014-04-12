class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.column :user_id, :integer
      t.column :name, :string
      t.column :location, :string
      t.column :age, :integer
      t.column :interests, :text
      t.column :wineloves, :text
      t.column :winehates, :text
      t.column :memories,  :text
      t.column :publicbottles, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
