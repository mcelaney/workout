require File.dirname(__FILE__) + '/../../app/services/workout/planning'

# Workout domain
#
module Workout
  RSpec.describe Planning do
    describe '#update_information' do
      let(:plan) { double }
      let(:current_user) { double(id: :the_user_id, plan: plan) }

      it 'Calls success if the plan baseline is valid' do
        controller = double(current_user: current_user)
        expect(plan).to receive(:assign_attributes)
        expect(plan).to receive(:valid?).and_return(true)
        expect(plan).to receive(:save!)
        Planning.new(
          controller,
          bench_press: 100
        ).update_information(
          success: lambda do |return_hash|
            @success_called = true
            @user_id = return_hash[:user_id]
          end
        )

        expect(@user_id).to eq :the_user_id
        expect(@success_called).to eq true
      end

      it 'Calls failure if the plan baseline is not valid' do
        controller = double(current_user: current_user)
        expect(plan).to receive(:assign_attributes)
        expect(plan).to receive(:valid?).and_return(false)
        expect(plan).to_not receive(:save!)
        Planning.new(
          controller,
          bench_press: 100
        ).update_information(
          failure: lambda do |return_hash|
            @failure_called = true
            @user = return_hash[:user_model]
          end
        )

        expect(@user).to eq current_user
        expect(@failure_called).to eq true
      end
    end
  end
end
