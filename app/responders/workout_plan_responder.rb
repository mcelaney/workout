# Module to add application directionality to workout plan controllers
#
module WorkoutPlanResponder
  private

  def change_success(user_id:)
    redirect_to user_path(user_id), notice: I18n.t('user.updated')
  end

  def change_failure(user_model:)
    user_model.load_workout_plan_params(workout_plan_params)
    @user = User.new(user_model)
    render 'users/show'
  end
end
