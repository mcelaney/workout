# View model for system users
#
class User
  include ActiveModel::Model

  delegate :email, :id, :errors, :password, :password_confirmation, :started?,
           :plan, to: :@model

  def initialize(user_instance)
    @model = user_instance
  end

  # Query: View Model for the user's current workout plan
  #
  # @return [WorkoutPlan]
  #
  def workout
    WorkoutPlan.new(plan)
  end
end
