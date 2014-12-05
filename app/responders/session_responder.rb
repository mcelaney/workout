# Module to add application directionality to session controllers
#
module SessionResponder
  private

  def log_in_success(user_id)
    session[:user_id] = user_id
    redirect_to user_path(user_id), notice: I18n.t('session.logged_in')
  end

  def log_in_failure
    flash.now.alert = I18n.t('session.invalid')
    render 'new'
  end
end
