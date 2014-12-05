# Workout domain
#
module Workout
  # The user module is responsible for representing the concept of users in the
  # system.
  #
  module Plan
    # Member model
    #
    # Represents a user who has a member record in our data
    #
    class Baseline < ActiveRecord::Base
      # Query: List of symbols for each exercise type available in the plan
      #
      # @todo Do this in a way that doesn't suck this much.
      # @return [Array<Symbol>]
      #
      EXERCISES = %i(
        bench_press
        lat_pull
        deadlift
        military_press
        one_arm_row
        curls
        squats
        dips
        pullups
      )

      belongs_to :member, class_name: 'Workout::User::Member'

      validates :member_id, presence: true
      validates :bench_press,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :lat_pull,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :deadlift,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :military_press,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :one_arm_row,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :curls,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :squats,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :dips,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true
      validates :pullups,
                numericality: {
                  message: I18n.t('form.errors.whole_number'),
                  only_integer: true,
                  greater_than: 0
                },
                allow_nil: true

      # Command: Add plan to a user
      #
      # @param user [Workout::User::Member]
      # @return [self]
      #
      def self.prepare_new_user(user)
        user.plans.create
        self
      end

      # Query: Returns a null object for an unknown plan
      #
      # @return [Workout::Unknown]
      #
      def self.unknown_plan
        Unknown.new
      end

      # Command: Assign params and run valid?
      #
      # Used to allow errors to show on workout plan forms on user show pages
      #
      # @params [Hash]
      # @return [self]
      #
      def load_workout_plan_params(params)
        assign_attributes(params)
        valid?
        self
      end

      # Query: Returns whether the current plan has started yet
      #
      # A plan is started once all the defaults have been filled out
      #
      # @return [Boolean]
      #
      def started?
        return true if all_defaults_set?
        false
      end

      # Query: Returns true if all EXERCISES have default values set
      #
      # @return [Boolean]
      #
      def all_defaults_set?
        return true unless EXERCISES.map do |exercise|
          try(exercise).present?
        end.include? false
        false
      end
    end
  end
end
