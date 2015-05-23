# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

neighborhoods = ['Williamsburg, Brooklyn', 'Park Slope, Brooklyn', 'Greenpoint, Brooklyn', 'Crown Heights, Brooklyn', 'Dumbo, Brooklyn']

neighborhoods.each do |neighborhood_name|
  neighborhood = Neighborhood.find_or_create_by(name: neighborhood_name)

  shop_response = Yelp.client.search(neighborhood_name, { term: 'coffee' })
  shop_response.businesses.each do |shop|
    Shop.create(name: shop.name, address: shop.location.address[0], neighborhood: neighborhood, rating: shop.rating)
  end
end