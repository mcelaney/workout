# View model for user workouts
#
class WorkoutPlan
  include ActiveModel::Model

  delegate :id, :member_id, :bench_press, :lat_pull, :deadlift, :military_press,
           :one_arm_row, :curls, :squats, :dips, :pullups, :valid?, :errors,
           to: :@model

  def initialize(workout_instance)
    @model = workout_instance
  end
end
