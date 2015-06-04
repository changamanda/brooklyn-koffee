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

    if !@shop.instagram_id
      id = Instagram.user_search(@shop.handle).find{|user| user["username"] == @shop.handle}["id"]
      @shop.update(instagram_id: id)
    end

    @images = Instagram.user_recent_media(@shop.instagram_id, {:count => 6})
    @shop.update(image_url: @images.first["images"]["standard_resolution"]["url"])
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

    @client = GooglePlaces::Client.new(ENV['GOOGLE_PLACES'])
    spots = @client.spots_by_query("#{@shop.address}, #{@shop.neighborhood.name}")
    @spot = spots.first

    respond_to do |format|
      format.json { render json: { shop: @shop, spot: @spot }}
    end
  end

  def map
  end

  def mapinfo
    @all_shops = Shop.where("rating >= 4 AND handle IS NOT NULL")
    @client = GooglePlaces::Client.new(ENV['GOOGLE_PLACES'])

    @all_spots = @all_shops.map{|shop| @client.spots_by_query("#{shop.address}, #{shop.neighborhood.name}").first }

    respond_to do |format|
      format.json { render json: { allShops: @all_shops, allSpots: @all_spots } }
    end
  end

end
