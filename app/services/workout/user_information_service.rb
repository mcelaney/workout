# Workout domain
#
module Workout
  # Collection of common functionality for services pertaining to users
  #
  module UserInformationService
    private

    # Command: Update an existing member
    #
    # Accepts a hash of lambdas - expects success and failure keys
    # - calls :success if current_user.valid? returns true
    # - falls :failure if current_user.valid? returns false
    #
    # @param events [Hash]
    # @return [self]
    #
    def update_object(object:, user:, events:)
      return _guarded_save(
        object,
        events[:success],
        user
      ) if object.valid?
      events[:failure].call(user_model: user)
    end

    def _guarded_save(object, event, user)
      object.save!
      event.call(user_id: user.id)
      self
    end
  end
end
