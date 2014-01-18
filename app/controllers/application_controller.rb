class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.  
	before_filter :configure_devise_params, if: :devise_controller?
  protect_from_forgery with: :exception    
  protected
    def configure_devise_params
    	devise_parameter_sanitizer.for(:sign_up) do 
    		|u| u.permit(:name, :location, :email, :password, :password_confirmation, :photo)
    	end
    	devise_parameter_sanitizer.for(:account_update) do
    		|u| u.permit(:name, :location, :email, :password, :password_confirmation, :current_password, :photo)
    end
  end
end
