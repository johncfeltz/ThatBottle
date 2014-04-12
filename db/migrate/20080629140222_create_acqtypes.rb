class CreateAcqtypes < ActiveRecord::Migration
  def self.up
    create_table :acqtypes do |t|
      t.column :acqtype, :string
    end
  end

  def self.down
    drop_table :acqtypes
  end
end
