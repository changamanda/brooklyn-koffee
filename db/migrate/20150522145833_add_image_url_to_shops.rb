class AddImageUrlToShops < ActiveRecord::Migration
  def change
    add_column :shops, :image_url, :string
  end
end
