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

    # Command: Update an existing plan
    #
    # Accepts a hash of lambdas - expects success and failure keys
    # - calls :success if current_user.valid? returns true
    # - falls :failure if current_user.valid? returns false
    #
    # @param events [Hash]
    # @return [self]
    #
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
