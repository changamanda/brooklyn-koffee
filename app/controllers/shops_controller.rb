class ShopsController < ApplicationController

  def index
    @handle_shops = Shop.where("rating >= 4 AND handle IS NOT NULL")
    @neighborhood_ids = @handle_shops.pluck(:neighborhood_id).uniq
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def show
    @quote = Quote.all.sample
    @shop = Shop.find(params[:id])

    # @shop.update_instagram_id

    @images = []
    # @images = @shop.instagram_images
    # @shop.update(image_url: @images.first["images"]["standard_resolution"]["url"])

    @shop.update_coords
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.update(handle: params[:shop][:handle])
    redirect_to @shop
  end

  def admin
    @handle_shops = Shop.where("rating >= 4 AND handle IS NOT NULL")
    @other_shops = Shop.where("rating >= 4 AND handle IS NULL")
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    redirect_to '/admin'
  end

  def info
    @shop = Shop.find(params[:id])

    respond_to do |format|
      format.json { render json: { shop: @shop }}
    end
  end

  def mapinfo
    @all_shops = Shop.where("rating >= 4 AND handle IS NOT NULL AND lat IS NOT NULL")

    respond_to do |format|
      format.json { render json: { allShops: @all_shops } }
    end
  end

end
