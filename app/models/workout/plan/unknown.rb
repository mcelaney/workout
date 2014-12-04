# Workout domain
#
module Workout
  # The user module is responsible for representing the concept of users in the
  # system.
  #
  module Plan
    # Null Object pattern for an unknown user
    #
    class Unknown
      include NullObject
    end
  end
end
