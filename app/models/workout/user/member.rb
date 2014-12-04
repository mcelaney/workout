# Workout domain
#
module Workout
  # The user module is responsible for representing the concept of users in the
  # system.
  #
  module User
    # Member model
    #
    # Represents a user who has a member record in our data
    #
    class Member < ActiveRecord::Base
      has_secure_password

      after_create :creation_successful

      has_many :plans,
               class_name: 'Workout::Plan::Baseline',
               dependent: :destroy

      validates_presence_of :password, on: :create
      validates :email,
                format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                presence: true,
                uniqueness: { case_sensitive: false }

      delegate :load_workout_plan_params, to: :plan

      # Finder: Looks for a user by email
      #
      # @param email [string] the email to search on
      # @return [Member] Will return self.unknown_user if not found
      #
      def self.find_by_email(email)
        Member.where(email: email).first || Member.unknown_user
      end

      # Finder: Looks for a user by id
      #
      # @param id [Integer] the id to search on
      # @return [Member] Will return self.unknown_user if not found
      #
      def self.find_by_id(id)
        Member.where(id: id).first || Member.unknown_user
      end

      # Query: Returns a null object for an unknown user
      #
      # @return [User::Unknown]
      #
      def self.unknown_user
        Unknown.new
      end

      # Query: Returns the most current baseline for the current user
      #
      # Currently this is a has_many relationship. I could have used a has_one
      # relationship however when I started there was more than one workout
      # plan available at a time. I quickly removed the multi-plan specs for MVP
      # but will add that back in at some point I think.
      #
      # @todo Set up multiple concurrent running workout plans for a single user
      # @return [Workout::Plan::Baseline]
      #
      def plan
        @_plan ||= plans.last
      end

      # Query: Returns the value of started? for the current plan
      #
      # @return [Boolean]
      #
      def started?
        return false if plan.nil?
        plan.started?
      end

      private

      def creation_successful
        ::Workout::Plan::Baseline.prepare_new_user(self)
      end
    end
  end
end
