# Workout domain
#
module Workout
  # Service to handle joining the website
  #
  class Joining
    delegate :current_user, to: :@listener

    def self.new_member
      Workout::User::Member.new
    end

    # Initializer: Accepts a controller and a params hash.
    # Expects params to include :email and :password keys
    #
    def initialize(listener, params)
      @listener = listener
      @params = params
    end

    # Command: create a new member
    #
    # Accepts a hash of lambdas - expects success and failure keys
    # - calls :success if new_user.valid? returns true
    # - falls :failure if new_user.valid? returns false
    #
    # @param events [Hash]
    # @return [self]
    #
    def create_member(events)
      if new_user.valid?
        new_user.save!
        events[:success].call(new_user.id)
      else
        events[:failure].call(new_user)
      end
    end

    # Command: create a new member
    #
    # Accepts a hash of lambdas - expects success and failure keys
    # - calls :success if current_user.valid? returns true
    # - falls :failure if current_user.valid? returns false
    #
    # @param events [Hash]
    # @return [self]
    #
    def update_information(events)
      current_user.assign_attributes(@params)
      if current_user.valid?
        current_user.save!
        events[:success].call(current_user.id)
      else
        events[:failure].call(current_user)
      end
    end

    private

    def new_user
      @_user ||= Workout::User::Member.new(@params)
    end
  end
end