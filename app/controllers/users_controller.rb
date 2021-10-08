class UsersController < ApplicationController
  
  layout "profile", only: [:profile_empty]

  def profile_empty; end
  def profile_finish
    param_name     = params[:profile][:name]
    param_username = params[:profile][:username]
    
    current_user.build_profile
  
    if param_name.blank? 
      return redirect_to profile_empty_users_path(username: param_username), alert: _("Nome não pode ficar em branco")
    else
      current_user.profile.name = param_name
    end

    if param_username.blank? 
      return redirect_to profile_empty_users_path(name: param_name), alert: _("Username não pode ficar em branco")
    else
      current_user.profile.username = param_username
    end

    respond_to do |format|
      if current_user.save
        format.html { redirect_to root_user_path }
      else
        flash[:alert] = current_user.profile.errors.full_messages.to_sentence
        format.html { render action: 'profile_empty' }
      end
    end
  end
  

end