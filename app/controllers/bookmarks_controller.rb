class BookmarksController < ApplicationController
  def create
    user_id = current_user.id
    shop_id = params[:shop_id]
    @bookmark = Bookmark.create(user_id: user_id, shop_id: shop_id)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @shop = Shop.find(@bookmark.shop_id)

    @bookmark.destroy

    respond_to do |format|
      format.js
    end
  end
end
