class CreateTastingevents < ActiveRecord::Migration
  def self.up
    create_table :tastingevents do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :tastingevents
  end
end
