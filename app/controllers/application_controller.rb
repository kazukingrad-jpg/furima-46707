class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '2222'
    end
  end

    def after_sign_up_path_for(resource)
    root_path  
  end
 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday
    ])
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
end
