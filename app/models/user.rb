class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookmarks

  def bookmark_id(shop)
    Bookmark.find_by(user_id: self.id, shop_id: shop.id).id
  end

  def bookmarked?(shop)
    Bookmark.find_by(user_id: self.id, shop_id: shop.id)
  end
end
