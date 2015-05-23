class BookmarksController < ApplicationController
  def create
    user_id = current_user.id
    shop_id = params[:shop_id]
    Bookmark.create(user_id: user_id, shop_id: shop_id)
    redirect_to shop_path(shop_id)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    shop_id = @bookmark.shop_id
    @bookmark.destroy
    redirect_to shop_path(shop_id)
  end
end
