require File.dirname(__FILE__) + '/../../app/models/workout_plan'

describe WorkoutPlan do
  describe 'plan' do
    it 'Returns a WorkoutPlan struct' do
      plan = WorkoutPlan.plan(percentages: :percentage_array, reps: :reps_array)
      expect(plan.percentages).to eq :percentage_array
      expect(plan.reps).to eq :reps_array
    end
  end

  describe 'workout1' do
    it 'Returns a WorkoutPlan struct' do
      expect(WorkoutPlan.workout1.percentages.class).to eq Array
      expect(WorkoutPlan.workout1.reps.class).to eq Array
    end
  end

  describe 'workouts' do
    it 'responds with workouts' do
      [
        :workout1, :workout2, :workout3, :workout4, :workout5, :workout6,
        :workout7, :workout8, :workout9, :workout10, :workout11, :workout12,
        :workout13, :workout14
      ].each do |workout|
        expect(WorkoutPlan).to respond_to(workout)
      end
    end
  end
end
