require 'rails_helper'

RSpec.describe 'WorkoutPlans', type: :request do
  context 'I am not a member' do
    describe 'update' do
      it 'Forwards to root' do
        patch user_workout_plan_path(1, 2)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
