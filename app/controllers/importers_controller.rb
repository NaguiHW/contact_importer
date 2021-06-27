class ImportersController < ApplicationController
  before_action :user_logged?

  def index
    @csv = Csv.new
  end

  def create
    headers = Csv.return_headers(params[:csv][:file])
    name = params[:csv][:file].original_filename
    @csv = Csv.new(csv_params.merge(user: current_user, headers: headers, name: name, status: 'On Hold'))
    if @csv.save
      # puts "url ==> #{url_for(@csv.file)}"
      flash[:success] = "Your csv file was uploaded correctly!"
      redirect_to all_csvs_path
    else
      flash[:alert] = "Something went wrong. Please try it again."
      render 'index'
    end
  end

  def show
    @csv = Csv.find(params[:id])
  end

  def all_csvs
    @csvs = current_user.csvs.order(created_at: :desc)
  end

  private

  def user_logged?
    redirect_to root_path if !logged_in?
  end

  def csv_params
    params.require(:csv).permit(:file)
  end
end
