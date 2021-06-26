class UsersController < ApplicationController
  def login
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      flash[:success] = "Your account was created successfully!"
      redirect_to root_path
    else
      render 'signup'
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
