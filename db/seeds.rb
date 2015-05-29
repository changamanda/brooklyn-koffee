# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

neighborhoods = ['Williamsburg, Brooklyn', 'Park Slope, Brooklyn', 'Greenpoint, Brooklyn', 'Crown Heights, Brooklyn', 'Dumbo, Brooklyn', 'Cobble Hill, Brooklyn', 'Fort Greene, Brooklyn']

neighborhoods.each do |neighborhood_name|
  neighborhood = Neighborhood.find_or_create_by(name: neighborhood_name)

  shop_response = Yelp.client.search(neighborhood_name, { term: 'coffee' })
  shop_response.businesses.each do |shop|
    Shop.create(name: shop.name, address: shop.location.address[0], neighborhood: neighborhood, rating: shop.rating)
  end
end

Quote.create(prose: "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.", author: "Helen Keller")
Quote.create(prose: "Live your beliefs and you can turn the world around.", author: "Henry David Thoreau")
Quote.create(prose: "I can't change the direction of the wind, but I can adjust my sails to always reach my destination.", author: "Jimmy Dean")
Quote.create(prose: "We know what we are, but know not what we may be.", author: "William Shakespeare")
Quote.create(prose: "My mission in life is not merely to survive, but to thrive; and to do so with some passion, some compassion, some humor, and some style.", author: "Maya Angelou")
Quote.create(prose: "Love has the most significant karmic impression on our souls.")
Quote.create(prose: "Life isn't about finding yourself. Life is about creating yourself.")