class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.text :description
      t.datetime :datetime
      t.integer :type_id
      t.integer :domain_id
      t.has_attached_file :thumbnail
      t.timestamps
    end
  end
end
