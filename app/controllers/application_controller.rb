# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  def current_user
    @_user ||= Credentialing.current_user(session.fetch(:user_id, nil))
  end

  helper_method :current_user?
  def current_user?
    current_user.id.present?
  end
end
