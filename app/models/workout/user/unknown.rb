# Workout domain
#
module Workout
  # The user module is responsible for representing the concept of users in the
  # system.
  #
  module User
    # Null Object pattern for an unknown user
    #
    class Unknown
      include NullObject

      # Query: Mimic .authenticate from has_secure_password module
      #
      # Always returns false because an unknown user can not authenticate
      #
      def authenticate(_)
        false
      end

      # Query: Mimic empty id parameter
      #
      def id
        nil
      end
    end
  end
end
