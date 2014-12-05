# Controller to manage session log in and log out resources
#
class SessionsController < ApplicationController
  include SessionResponder

  # action: Login form
  #
  def new
  end

  # action: Login action
  #
  # Calls log_in on the credentialing service. Sends success and failure lambdas
  # - success: calls log_in_success private method to set the user_id in session
  #   and forward the user
  # - failure: calls log_in_failure to re-render the login form
  #
  def create
    credentialing.log_in(
      success: -> (user_id:) { log_in_success(user_id) },
      failure: -> { log_in_failure }
    )
  end

  # action: Logout action
  #
  # Removes user_id from session and redirects the user
  #
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: I18n.t('session.logged_out')
  end

  private

  def credentialing
    Workout::Credentialing.new(self, credential_params)
  end

  def credential_params
    params.permit(:email, :password)
  end
end
