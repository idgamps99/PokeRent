class UsersController < ApplicationController
  # Make sure user is logged in
  before_action :authenticate_user!

  def profile
    @user = current_user
    @avatars = {
      "Ash" => "/app/assets/images/ash-pp.png",
      "Professor Oak" => "/app/assets/images/prof-oak-pp.jpeg",
      "Brock" => "/app/assets/images/brock-pp.jpg",
      "Hilda" => "/app/assets/images/hilda-pp.jpg"
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

  def my_pokemons
    @pokemons = Pokemon.where(user_id: params[:user])
  end
end
