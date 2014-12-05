# Controller to manage workout plans
#
class WorkoutPlansController < ApplicationController
  include WorkoutPlanResponder

  before_filter :authorize

  # action: Update user action
  #
  # Calls update_information on planning service. Sends success and failure
  # - success: calls plan_change_success private method to forward the user
  # - failure: calls plan_change_failure to re-render the account edit form
  #
  def update
    planning.update_information(
      success: -> (user_id:) { change_success(user_id: user_id) },
      failure: -> (user_model:) { change_failure(user_model: user_model) }
    )
  end

  private

  def planning
    Workout::Planning.new(self, workout_plan_params)
  end

  def request_for_current_user?
    current_user_is?(params[:user_id].to_i)
  end

  def workout_plan_params
    params.require(:workout_plan).permit(Workout::Plan::Baseline::EXERCISES)
  end
end
