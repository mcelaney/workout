require File.dirname(__FILE__) + '/../../app/models/workout_plan'

RSpec.describe WorkoutPlan do
  describe 'plan' do
    it 'Returns a WorkoutPlan struct' do
      plan = WorkoutPlan.plan(percentages: :percentage_array, reps: :reps_array)
      expect(plan.percentages).to eq :percentage_array
      expect(plan.reps).to eq :reps_array
    end
  end

  describe 'workouts' do
    it 'Returns a WorkoutPlan struct' do
      workout_loop(
        lambda do |workout|
          expect(WorkoutPlan.send(workout).percentages.class).to eq Array
          expect(WorkoutPlan.send(workout).reps.class).to eq Array
        end
      )
    end
  end

  describe 'workouts' do
    it 'responds with workouts' do
      workout_loop(->(workout) { expect(WorkoutPlan).to respond_to(workout) })
    end
  end

  private

  def workout_loop(method_to_perform)
    [
      :workout1, :workout2, :workout3, :workout4, :workout5, :workout6,
      :workout7, :workout8, :workout9, :workout10, :workout11, :workout12,
      :workout13, :workout14
    ].each do |workout|
      method_to_perform.call(workout)
    end
  end
end
