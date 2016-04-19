class ApplicationController < ActionController::Base

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token
  after_action :change_chat

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
  end

  def change_chat
    if current_user && current_user.connects.count > 1
      current_user.connects[0..-2].each do |i|
        i.destroy
      end
    end
  end

end
