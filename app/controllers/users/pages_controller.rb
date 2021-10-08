class Users::PagesController  < ApplicationController
  
  skip_before_action :authenticate_user!, :verify_user_have_username

  def welcome; end
  
  def see_your_email; end
  
end