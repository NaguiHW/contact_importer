class ApplicationController < ActionController::Base
  include SessionsHelper

  def connected_user?
    redirect_to importers_path if logged_in?
  end
end
