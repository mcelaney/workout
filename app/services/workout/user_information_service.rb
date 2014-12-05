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
      if object.valid?
        object.save!
        events[:success].call(user_id: user.id)
      else
        events[:failure].call(user_model: user)
      end
    end
  end
end
