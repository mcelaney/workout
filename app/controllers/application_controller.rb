# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_user?
  helper_method :current_user_is?

  # Query: Returns the current user based on the user_id in session
  #
  # @return [Workout::Member|Workout::UnknownUser]
  #
  def current_user
    @_user ||= Workout::Credentialing.current_user(session.fetch(:user_id, nil))
  end

  # Query: Returns true if current_user has an id defined
  #
  # @return [Boolean]
  #
  def current_user?
    current_user.id.present?
  end

  # Query: Returns true if current_user has an id defined
  #
  # @param user_id [Integer] Id of user to test
  # @return [Boolean]
  #
  def current_user_is?(user_id)
    current_user.id == user_id
  end

  private

  def authorize
    return if current_user? && request_for_current_user?

    flash.now.alert = I18n.t('session.invalid')
    redirect_to root_url, alert: I18n.t('session.not_authorized')
  end
end
