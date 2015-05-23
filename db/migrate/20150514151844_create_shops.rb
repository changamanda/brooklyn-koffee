class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.integer :neighborhood_id
      t.string :handle
      t.float :rating

      t.timestamps null: false
    end
  end
end
