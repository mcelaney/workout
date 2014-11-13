require File.dirname(__FILE__) + '/../../app/models/workout_detail'

RSpec.describe WorkoutDetail do
  let(:plan) do
    class_double(
      'WorkoutPlan', workout1: double(percentages: [0.52], reps: [2])
    )
  end

  describe '#weight_for_set' do
    it 'returns a weight for the requested set' do
      detail = WorkoutDetail.new(workout: 1, rep_max: 50, plan: plan)
      expect(detail.weight_for_set(1)).to eq 26
    end

    it 'rounds values for rep_max > 100 to 5' do
      detail = WorkoutDetail.new(workout: 1, rep_max: 200, plan: plan)
      expect(detail.weight_for_set(1)).to eq 105
    end
  end

  describe '#reps_for_set' do
    it 'returns a reps for the requested set' do
      detail = WorkoutDetail.new(workout: 1, rep_max: 50, plan: plan)
      expect(detail.reps_for_set(1)).to eq 2
    end
  end
end
