class CreateAppellations < ActiveRecord::Migration
  def self.up
    create_table :appellations do |t|
      t.column :name, :string
      t.column :notes, :text
      t.column :parentappellation_id, :integer
      t.column :apptype_id, :integer
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.column :winescount, :integer    # temporary for data upload only.  Kill this in the DBMS after migration
                                        # from beta 1B to beta 2.
      t.timestamps
    end
  end

  def self.down
    drop_table :appellations
  end
end
