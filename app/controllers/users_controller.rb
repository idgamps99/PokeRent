class UsersController < ApplicationController
  # Make sure user is logged in
  before_action :authenticate_user!

  def profile
    @user = current_user
    @avatars = ["/app/assets/images/ash-pp.png", "/app/assets/images/prof-oak-pp.jpeg", "/app/assets/images/brock-pp.jpg", "/app/assets/images/hilda-pp.jpg"]
  end

  def update_avatar
    @user = current_user
    if @user.update(avatar_name: params[:avatar_name])
      redirect_to authenticated_profile_path
    else
      render :profile
    end
  end
end
