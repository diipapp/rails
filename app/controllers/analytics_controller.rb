class AnalyticsController < ApplicationController
  
  skip_before_action :authenticate_user!, :verify_user_have_username, only: [:increment]
  before_action :set_user, only: [:increment]

  def show; end
  def increment
    case params[:type_analytic]
    when "category"
      @category = Category.find_by_id(params[:type_id])
      not_found_crude unless @category.present?
    when "tip"
      @tip = Recomendation.find_by_id(params[:type_id])
      not_found_crude unless @tip.present?
    end
    
    @user.analytics.increment(@user.id, params['type_analytic'], params['type_id'])

    redirect_to @tip.url if params[:type_analytic] == "tip"
  end  

  private
  
    def set_user
      @user = User.find_by_id(params[:user_id])
      not_found_crude unless @user.present?
    end   
    
end