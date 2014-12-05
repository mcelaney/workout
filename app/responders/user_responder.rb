# Module to add application directionality to user controllers
#
module UserResponder
  private

  def change_success(user_id:)
    redirect_to user_path(user_id), notice: I18n.t('user.updated')
  end

  def change_failure(user_model:)
    @user = User.new(user_model)
    render :edit
  end

  def creation_success(user_id:)
    session[:user_id] = user_id
    redirect_to root_url, notice: I18n.t('session.logged_in')
  end

  def creation_failure(user_model:)
    @user = User.new(user_model)
    render :new
  end
end
