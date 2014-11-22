# Workout domain
#
module Workout
  # Returns details for workout sets
  #
  class WorkoutDetail
    attr_reader :rep_max

    # initialize a new WorkoutDetail
    #
    # @param [Integer] rep_max: value of 1 rep max
    # @param [Integer] workout: workout to return data for
    # @param [WorkoutPlan] plan: a WorkoutPlan object containing the data
    # @return [WorkoutDetail]
    #
    def initialize(rep_max:, workout:, plan:)
      @rep_max = rep_max
      @workout = workout
      @plan = plan
    end

    # Query: Returns the weight to use for a given set
    #
    # @todo Handle set doesn't exist
    #
    # @param set [Integer] workout set
    # @return [Integer] weight to lift
    #
    def weight_for_set(set)
      return weight_rounded_to_five(set) if rep_max > 100

      weight_rounded_to_whole_integer(set)
    end

    # Query: Returns the number of reps to use for a given set
    #
    # @todo Handle set doesn't exist
    #
    # @param set [Integer] workout set
    # @param [Integer] number of lifts to perform
    def reps_for_set(set)
      @plan.send(current_workout).reps[set - 1]
    end

    private

    def percentage_for_set(set)
      @plan.send(current_workout).percentages[set - 1]
    end

    def adjusted_rep_max(set)
      rep_max * percentage_for_set(set)
    end

    def weight_rounded_to_whole_integer(set)
      adjusted_rep_max(set).round
    end

    def weight_rounded_to_five(set)
      (adjusted_rep_max(set) / 5).round * 5
    end

    def current_workout
      ('workout' + @workout.to_s).to_sym
    end
  end
end
