class ApplicationController < ActionController::Base  
  
  include HttpAcceptLanguage::AutoLocale
  include Response
  
  layout :resolve_layout

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  before_action :authenticate_user!
  before_action :verify_user_have_username, :except => [:profile_empty, :profile_finish, :extract_url]

  private

    def resolve_layout
      if devise_controller? 
        "login" 
      elsif params[:controller] == "diip"
        "profile"        
      else
        "dashbord"
      end
    end
      
    def after_sign_in_path_for(resource)
      root_user_path
    end

    def verify_user_have_username
      unless devise_controller? || (params[:controller] == 'users/recomendations' && (params[:action] == 'index' || params[:action] == 'create' || params[:action] == 'destroy' || params[:action] == 'update')) 
        redirect_to profile_empty_users_path if current_user.profile.nil? || current_user.profile.name.blank? || current_user.profile.username.blank?
      end
    end

    def not_found_crude
      head 404, "content_type" => 'text/plain'
    end    

    def not_found_beautiful
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end    

end
