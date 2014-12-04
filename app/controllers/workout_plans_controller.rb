# Controller to manage workout plans
#
class WorkoutPlansController < ApplicationController
  before_filter :authorize

  # action: Update user action
  #
  # Calls update_information on planning service. Sends success and failure
  # - success: calls plan_change_success private method to forward the user
  # - failure: calls plan_change_failure to re-render the account edit form
  #
  def update
    planning.update_information(
      success: -> (user_id:) { plan_change_success(user_id: user_id) },
      failure: -> (user_model:) { plan_change_failure(user_model: user_model) }
    )
  end

  private

  def authorize
    return if current_user? && request_for_current_user?

    flash.now.alert = I18n.t('session.invalid')
    redirect_to root_url, alert: I18n.t('session.not_authorized')
  end

  def plan_change_success(user_id:)
    redirect_to user_path(user_id), notice: I18n.t('user.updated')
  end

  def plan_change_failure(user_model:)
    user_model.load_workout_plan_params(workout_plan_params)
    @user = User.new(user_model)
    render 'users/show'
  end

  def planning
    Workout::Planning.new(self, workout_plan_params)
  end

  def request_for_current_user?
    current_user.id == params[:id].to_i
  end

  def workout_plan_params
    params.require(:workout_plan).permit(Workout::Plan::Baseline::EXERCISES)
  end
end
