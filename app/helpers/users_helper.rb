module UsersHelper
  def image_if_image
    image_tag @user.image, width: 200 if @user.image.url
  end

  def edit_image_if_current_user
    link_to("Edit Photo", edit_photo_path(@user.id), class: "btn btn-default btn-xs", id: "photo-button") if @user == current_user
  end
end
