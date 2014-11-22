# Workout domain
#
module Workout
  # Factory for 1 rep max increase workout plans
  #
  class WorkoutPlan
    # Workout Plan factory method
    #
    # Workout plans respond to percentages and reps for the required sets
    #
    # @param [Array] percentages: The weight percentages to lift
    # @param [Array] reps: The number of times to lift
    # @return [Struct] workout plan
    #
    def self.plan(percentages:, reps:)
      Struct.new(:percentages, :reps).new(percentages, reps)
    end

    # Workout information for the first week
    #
    # @return [Struct] workout plan
    #
    def self.workout1
      plan(percentages: [0.75, 0.80, 0.80], reps: [6, 5, 4])
    end

    # Workout information for the second week
    #
    # @return [Struct] workout plan
    #
    def self.workout2
      plan(percentages: [0.85, 0.90, 1.00], reps: [3, 2, 'Negative'])
    end

    # Workout information for the third week
    #
    # @return [Struct] workout plan
    #
    def self.workout3
      plan(percentages: [0.75, 0.80, 0.85], reps: [6, 5, 4])
    end

    # Workout information for the forth week
    #
    # @return [Struct] workout plan
    #
    def self.workout4
      plan(percentages: [0.90, 0.95, 1.05], reps: [3, 2, 'Negative'])
    end

    # Workout information for the fifth week
    #
    # @return [Struct] workout plan
    #
    def self.workout5
      plan(percentages: [0.80, 0.85, 0.90], reps: [6, 5, 'Fail'])
    end

    # Workout information for the sixth week
    #
    # @return [Struct] workout plan
    #
    def self.workout6
      plan(percentages: [0.90, 1.00, 1.10], reps: [3, 2, 'Negative'])
    end

    # Workout information for the seventh week
    #
    # @return [Struct] workout plan
    #
    def self.workout7
      plan(percentages: [0.85, 0.95, 0.95], reps: [5, 3, 'Fail'])
    end

    # Workout information for the eigth week
    #
    # @return [Struct] workout plan
    #
    def self.workout8
      plan(percentages: [0.95, 1.00, 1.10], reps: [3, 1, 'Negative'])
    end

    # Workout information for the ninth week
    #
    # @return [Struct] workout plan
    #
    def self.workout9
      plan(percentages: [0.90, 1.00, 1.00], reps: [5, 3, 'Fail'])
    end

    # Workout information for the tenth week
    #
    # @return [Struct] workout plan
    #
    def self.workout10
      plan(percentages: [1.00, 1.10, 1.10], reps: [3, 2, 1])
    end

    # Workout information for the eleventh week
    #
    # @return [Struct] workout plan
    #
    def self.workout11
      plan(percentages: [0.95, 1.00, 1.00], reps: [5, 3, 'Fail'])
    end

    # Workout information for the twelth week
    #
    # @return [Struct] workout plan
    #
    def self.workout12
      plan(percentages: [1.00, 1.10, 1.15], reps: [3, 2, 1])
    end

    # Workout information for the thirteenth week
    #
    # @return [Struct] workout plan
    #
    def self.workout13
      plan(percentages: [1.00, 1.10, 1.15], reps: [5, 3, 2])
    end

    # Workout information for the fourteenth week
    #
    # @return [Struct] workout plan
    #
    def self.workout14
      plan(percentages: [1.00, 1.15, 1.20], reps: [3, 2, 1])
    end
  end
end
