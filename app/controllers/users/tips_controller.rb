class Users::TipsController < ApplicationController
  
  skip_before_action :authenticate_user!, :verify_user_have_username
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  
  before_action :set_user, :set_recomendation
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

  # =~
  # TODO: Dar uma mensagem que nao existe
  def destroy
    @recomendation.destroy if @recomendation.present?
    head :no_content
  end
    
  private

    def set_user
      @user = User.find_by_id(params[:user_id])
      not_found_crude unless @user.present?
    end
  
    def set_recomendation
      @recomendation = @user.recomendations.where(id: params[:id]).last
      return raise "invalid" unless @recomendation.present?
    end

  # def recomendation_params
    #   params.permit(:user_id, :category_id, :title, :url, :image, :price, :visible, :order)
    # end

    # def set_recomendations
    #   @recomendations = @user.recomendations.where(category_id: params[:category_id])
    # end



end