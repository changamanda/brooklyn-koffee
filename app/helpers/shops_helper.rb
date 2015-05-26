module ShopsHelper
  def save_or_unsave
    if current_user
      !current_user.bookmarked?(@shop) ? link_to("Save This.", shop_bookmarks_path(@shop.id), method: :post, class: "btn btn-default") : link_to("Nah.", bookmark_path(current_user.bookmark_id(@shop)), method: :delete, class: "btn btn-default")
    end
  end

  def author_if_author
    " – #{@quote.author}" if @quote.author
  end
end
