class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_active])
  end
  def require_admin
    user = AdminUser.find_by(:email => current_user.email)
    if user.blank?
      redirect_to root_path
    end
  end
  def require_permitted_user
    user = PermittedUser.find_by(:email => current_user.email)
    if user.blank? or current_user.is_active.blank?
      sign_out current_user
      redirect_to sign_in_path, alert: 'ユーザー登録されていません'
    end
  end
end
