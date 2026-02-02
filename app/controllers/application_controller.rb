class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ]) # 登録時にnameを許可
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def record_not_found
    redirect_to posts_path, alert: "権限がありません"
  end
end
