# Workout domain
#
module Workout
  # Service to handle planning a workout
  #
  class Planning
    include UserInformationService

    delegate :current_user, to: :@listener

    def initialize(listener, params)
      @listener = listener
      @params = params
    end

    def update_information(events)
      plan.assign_attributes(@params)
      update_object(
        object: plan,
        user: current_user,
        events: events
      )
    end

    private

    def plan
      @_plan ||= current_user.plan
    end
  end
end
