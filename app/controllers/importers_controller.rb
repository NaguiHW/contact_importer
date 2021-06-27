class ImportersController < ApplicationController
  before_action :user_logged?

  def index
  end

  private

  def user_logged?
    redirect_to root_path if !logged_in?
  end
end
