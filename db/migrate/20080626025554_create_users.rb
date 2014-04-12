class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :handle, :string
      t.column :fullname, :string
      t.column :dob, :date
      t.column :email, :string
      t.column :password, :string
      t.column :userstatus_id, :integer
      t.column :betauser, :integer
      t.column :lastlogin, :datetime
      t.column :authorization_token, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
