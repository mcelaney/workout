# View helper for user-related functionality
#
module UserHelper
  # Returns an optional edit link
  #
  # @param user_id [Integer]
  # @return [String]
  #
  def edit_user_link(user_id)
    return '' unless current_user_is?(user_id)
    link_to I18n.t('form.edit'), edit_user_path(user_id)
  end

  # Returns an optional workout sumary
  #
  # If defaults are set returns standard summary. Otherwaise returns the
  # start_workout partial
  #
  def workout_program(user)
    return workout_summary(user) if user.started?
    start_workout(user)
  end

  private

  def start_workout(user)
    render partial: 'users/workouts/start', locals: { workout: user.workout }
  end

  def workout_summary(user)
    render partial: 'workouts/workout', locals: { workout: user.workout }
  end
end
