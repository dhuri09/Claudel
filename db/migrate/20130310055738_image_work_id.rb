class ImageWorkId < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.integer :work_id
    end
  end
end
