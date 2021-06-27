class UsersController < ApplicationController
  before_action :connected_user?, only: %i[signup]
  
  def signup
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Your account was created successfully!"
      redirect_to importers_path
    else
      render 'signup'
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
