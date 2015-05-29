class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def editphoto
    @user = User.find(params[:id])
  end

  def updatephoto
    @user = User.find(params[:id])
    @user.update(user_photo_params)

    redirect_to @user
  end

  private
    def user_photo_params
      params.require(:user).permit(:image)
    end
end
