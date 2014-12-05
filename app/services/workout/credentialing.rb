# Workout domain
#
module Workout
  # Service to handle credentialing
  #
  class Credentialing
    # Initializer: Accepts a controller and a params hash.
    # Expects params to include :email and :password keys
    #
    def initialize(listener, params)
      @listener = listener
      @email = params[:email]
      @password = params[:password]
    end

    # Query: returns a user object
    #
    # @param [Integer] the user id to search for
    # @return [User::Member] A user object of user null object
    #
    def self.current_user(user_id)
      User::Member.find_by_id(user_id)
    end

    # Command: Attempts to authenticate a user
    #
    # Accepts a hash of lambdas - expects success and failure keys
    # - calls :success if user.authenticate returns true
    # - falls :failure if user.authenticate returns false
    #
    # If user.authenticate fails we sleep for a random fraction of .25 of a
    # second. This is done as a defense against timing attacks.
    #
    # @param events [Hash]
    # @return [self]
    #
    def log_in(events)
      return guarded(events[:success], user_id: user.id) if authed?(user)
      sleep(rand * 0.25)
      events[:failure].call
      self
    end

    private

    def authed?(user)
      user.authenticate(@password)
    end

    def user
      @_user ||= User::Member.find_by_email(@email)
    end

    def guarded(method, params)
      method.call(params)
      self
    end
  end
end
