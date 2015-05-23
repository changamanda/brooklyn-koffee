class Shop < ActiveRecord::Base
  belongs_to :neighborhood
  has_many :bookmarks
end
