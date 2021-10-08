class User < ApplicationRecord
  
  include Tokenable

  # Associations
  has_one :profile, class_name: "UserProfile", dependent: :destroy
  has_many :recomendations, dependent: :destroy
  has_many :analytics, dependent: :destroy
  
  # Allow saving of attributes on associated records through the parent,
  # :autosave option is automatically enabled on every association
  accepts_nested_attributes_for :profile  
  
  # Punching Bag is a hit tracking plugin for Ruby on Rails that specializes in simple trending.
  # https://github.com/biola/punching_bag
  acts_as_punchable

  # Include default devise modules. Others available are:
  # https://github.com/heartcombo/devise
  devise :database_authenticatable,
         :trackable,
         :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  def self.from_omniauth(access_token, signed_in_resourse=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid).first

    if user
      return user
    else
      registered_user = User.where(:email => data["email"]).first

      if registered_user
        registered_user.update(provider: access_token.provider, uid: data["uid"])

        return registered_user
      else
        user = User.create(
          provider: access_token.provider,
          email: data["email"],
          uid: data["uid"],
          password: Devise.friendly_token[0,20],
          confirmed_at: Time.now.utc
        )

        user.build_profile
        user.profile.name = data["name"]

        return user
      end
    end
  end

  def update_without_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    
    clean_up_passwords
    update(params, *options)
  end  

  def recomendations_by_category(category_id)
    recomendations.where(category_id: category_id)
  end

  def analytics_by_categories
    categories = Category.left_outer_joins(:analytic) 
                          .select("categories.*, analytics.total")
                          .order(order: :asc)

    result = {}
    categories.each do |analytic|
      result[analytic.emoji] = analytic.total.to_i
    end
    result
  end

  def analytics_by_tips
    self.recomendations
        .includes(:analytics) 
        .select("recomendations.*, analytics.total")
        .order("analytics.total ASC")
  end  

end