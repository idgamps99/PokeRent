class UsersController < ApplicationController
  # Make sure user is logged in
  before_action :authenticate_user!

  def profile
    @user = current_user
    @avatars = {
      Ash: "ash-pp.png",
      ProfessorOak: "prof-oak-pp.jpeg",
      Brock: "brock-pp.jpg",
      Hilda: "hilda-pp.jpg"
    }
  end

  def update_avatar
    @user = current_user
    if @user.update(avatar_name: params[:user][:avatar_name])
      redirect_to authenticated_profile_path
    else
      render :profile
    end
  end
end
