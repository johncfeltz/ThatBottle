class CreateTastingnotes < ActiveRecord::Migration
  def self.up
    create_table :tastingnotes do |t|
      t.column :tastingevent_id, :integer
      t.column :tastingdate, :date
      t.column :tasteable_id, :integer    # polymorphic association
      t.column :tasteable_type, :string   # can be either 'Bottle' or 'Wine'  (case is important)
      
      t.column :vintage, :integer     # if polymorphic to bottle, hide this; use only
                                      #   with wine
      t.column :user_id, :integer
      t.column :visual, :text
      t.column :olfactory, :text
      t.column :gustatory, :text
      t.column :score, :integer     # straight 0-10 score for quality
      t.column :worth, :integer     # 1-5 score indicating value-for-money
                                    # 1=ripoff, 2=expensive, 3=average, 4=bargain, 5=steal
      t.column :notes, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :tastingnotes
  end
end
