class ImportersController < ApplicationController
  before_action :user_logged?

  def index
    @csv = Csv.new
  end

  def create
    @csv = Csv.new(csv_params.merge(user: current_user))
    if @csv.save
      flash[:success] = "Your csv file was uploaded correctly!"
    else
      flash[:alert] = "Something went wrong. Please try it again."
    end
    redirect_back(fallback_location: importers_path)
  end

  private

  def user_logged?
    redirect_to root_path if !logged_in?
  end

  def csv_params
    params.require(:csv).permit(:file)
  end
end
