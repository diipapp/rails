class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters

  protected

    def configure_permitted_parameters      
      profile_variables = [:name, :username, :spotify, :youtube, 
                           :twitter, :twitch, :tiktok, :instagram, 
                           :pinterest, :site, :facebook, :medium, :behance,
                           :linkedin, :whatsapp, :email
                          ]
      attributes = [:password, :password_confirmation, profile_attributes: profile_variables]
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end    

    # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-account-without-providing-a-password
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def after_update_path_for(resource)
      root_user_path
    end    

    def after_inactive_sign_up_path_for(resource)
      welcome_path
    end    

end