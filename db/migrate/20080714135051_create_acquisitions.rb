class CreateAcquisitions < ActiveRecord::Migration
  def self.up
    create_table :acquisitions do |t|
      t.column :acqdate, :date
      t.column :source, :text
      t.column :user_id, :integer
      t.column :acqtype_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :acquisitions
  end
end
