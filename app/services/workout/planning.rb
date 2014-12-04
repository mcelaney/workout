# Workout domain
#
module Workout
  # Service to handle planning a workout
  #
  class Planning
    delegate :current_user, to: :@listener

    def initialize(listener, params)
      @listener = listener
      @params = params
    end

    def update_information(events)
      plan.assign_attributes(@params)
      if plan.valid?
        plan.save!
        events[:success].call(current_user.id)
      else
        events[:failure].call(current_user)
      end
    end

    private

    def plan
      @_plan ||= current_user.plan
    end
  end
end
