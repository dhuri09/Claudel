class CreateTimePeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|
      t.string :name
      t.timestamps
    end
    change_table :works do |t|
      t.remove :datetime
      t.integer :time_period_id
    end
  end
end
