class TipsController < ApplicationController
  
  # skip_before_action :authenticate_user!, :verify_user_have_username
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  
  before_action :set_recommendation
  # before_action :set_recomendation, only: [:destroy, :update]
  # before_action :set_recomendations, only: [:index, :create, :destroy]

 

  # def index
  #   json_response(@recomendations)
  # end

  # def create
  #   create = Recomendation.create!(recomendation_params)
  #   json_response(create, :created)
  # end

  # def update
  #   @recomendation.update(recomendation_params)
  #   json_response(@recomendation)
  # end

  def destroy
    @recomendation.destroy 
  end
    
  private

    def set_user
      @user = User.find_by_id(params[:user_id])
      not_found_crude unless @user.present?
    end
  
    def set_recommendation
      @recomendation = Recomendation.find_by_id(params[:id])
    end

end