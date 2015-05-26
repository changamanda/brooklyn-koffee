module ShopsHelper
  def save_or_unsave
    if current_user
      !current_user.bookmarked?(@shop) ? link_to("Save This.", shop_bookmarks_path(@shop.id), method: :post, class: "btn btn-default") : link_to("Nah.", bookmark_path(current_user.bookmark_id(@shop)), method: :delete, class: "btn btn-default")
    end
  end

  def bookmark_or_unbookmark
    if current_user
      !current_user.bookmarked?(@shop) ? link_to(fa_icon("bookmark-o"), shop_bookmarks_path(@shop.id), method: :post, remote: true) : link_to(fa_icon("bookmark"), bookmark_path(current_user.bookmark_id(@shop)), method: :delete, remote: true)
    end
  end

  def author_if_author
    " – #{@quote.author}" if @quote.author
  end
end
