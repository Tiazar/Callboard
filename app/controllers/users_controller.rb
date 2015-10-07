class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      redirect_to @user
    else
      render 'new'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :login, :email, :birthday,
     :address, :city, :state, :country, :zip, :password,
     :password_confirmation)
  end
end