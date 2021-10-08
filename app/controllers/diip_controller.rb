class DiipController < ApplicationController

  skip_before_action :authenticate_user!, :verify_user_have_username

  before_action :set_user

  # def privacy; end
  # def not_found_username; end

  def profile
    @categories = Category.joins(:recomendations)
                          .where(recomendations: { user_id: @user.id })
                          .group(:category_id, :emoji, :order, :name)
                          .order(order: :asc)
                          .select(:category_id)
                          .count(:category_id)

    @user.punch(request)                          
  end

  # def index
  #   @recomendations = @user.recomendations
  #                          .where(visible: true)
  #                          .select(:id,
  #                                  :category_id, 
  #                                  :title, 
  #                                  :url, 
  #                                  :image,
  #                                  :price,
  #                                  :order)

  #   json_response({recomendations: @recomendations, social_links: @user.profile.social_links})
  # end

  # private

    def set_user
      @user = User.includes(:profile).where(user_profiles: {username: params[:username].unaccent.downcase}).last
      not_found_beautiful unless @user.present?
    end

  #   def content_not_found
  #     render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  #   end
  
end