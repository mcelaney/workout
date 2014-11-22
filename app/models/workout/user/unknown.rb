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

      attr_reader :email, :id

      # Query: Mimic .authenticate from has_secure_password module
      #
      # @param _ [Object] Ignored param
      # @return [Boolean] Always returns false
      #
      def authenticate(_)
        false
      end

      # Query: Mimic .errors
      #
      # @return [Array] Always returns empty array
      #
      def errors
        []
      end
    end
  end
end
