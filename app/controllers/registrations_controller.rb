class RegistrationsController < Devise::RegistrationsController
before_filter :configure_permitted_parameters, if: :devise_controller?
  protected

    def after_update_path_for(resource)
      user_path(resource)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:name, :login, :email, :birthday,
         :address, :city, :state, :country, :zip, :password, :avatar, :password_confirmation)
      end

      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:name, :login, :email, :birthday,
         :address, :city, :state, :country, :zip, :password, :avatar, :password_confirmation,
          :current_password )
      end

    end

    def after_sign_in_path_for(resource)
      current_user
    end

    def after_sign_out_path_for(resource_or_scope)
      request.referrer
    end
end
