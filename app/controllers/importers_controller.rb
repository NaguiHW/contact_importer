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
    @csvs = current_user.csvs.order(created_at: :asc)
  end

  def start_process
    column = params[:column]
    name = column[:name]
    date_of_birth = column[:date_of_birth]
    phone = column[:phone]
    address = column[:address]
    credit_card = column[:credit_card]
    email = column[:email]
    Csv.find(column[:csv_id]).update(status: 'Processing')
    arr = [name, date_of_birth, phone, address, credit_card, email]
    arr_uniq = arr.uniq
    if arr == arr_uniq
      path =ActiveStorage::Blob.service.path_for(Csv.find(column[:csv_id]).file.key)
      Csv.import(path, name, date_of_birth, phone, address, credit_card, email, current_user)
    else
      Csv.find(column[:csv_id]).update(status: 'Failed')
      flash[:alert] = "You selected the same column for distinct values."
    end
    redirect_to all_csvs_path
  end

  private

  def user_logged?
    redirect_to root_path if !logged_in?
  end

  def csv_params
    params.require(:csv).permit(:file)
  end

  def validate_credit_card(credit_card)
    card_string = credit_card.to_s
    puts "card_string => #{card_string}"
    case card_string
    when card_string[0] == "1"
      if card_string.length == 15
        return [card_string.last(4), 'UATP']
      end
    end
  end
end
