class Shop < ActiveRecord::Base
  belongs_to :neighborhood
  has_many :bookmarks

  def update_coords
    if !self.lat || !self.lng
      client = GooglePlaces::Client.new(ENV['GOOGLE_PLACES'])
      spots = client.spots_by_query("#{self.address}, #{self.neighborhood.name}")
      spot = spots.first
      self.update(lat: spot.lat, lng: spot.lng)
    end
  end

  def update_instagram_id
    if !self.instagram_id
      id = Instagram.user_search(self.handle).find{|user| user["username"] == self.handle}["id"]
      self.update(instagram_id: id)
    end
  end

  def instagram_images
    Instagram.user_recent_media(self.instagram_id, {:count => 6})
  end
end
