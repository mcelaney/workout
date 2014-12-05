# Workout domain
#
module Workout
  # Collection of common functionality for services pertaining to users
  #
  module UserInformationService
    private

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
