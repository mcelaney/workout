require File.dirname(__FILE__) + '/../../app/services/workout/credentialing'

# Workout domain
#
module Workout
  RSpec.describe Credentialing do
    let(:authenticatable) { double(id: :the_user_id) }
    let(:unauthenticatable) { double }
    let(:missing) { double }

    describe '.current_user' do
      it 'calls User::Member.find_by_id' do
        expect(User::Member).to receive(:find_by_id).with(:a_user_id)
        Credentialing.current_user(:a_user_id)
      end
    end

    describe '#log_in' do
      it 'Calls success if the User::Member exists and can authenticate' do
        expect(User::Member).to receive(:find_by_email)
          .with(:an_email)
          .and_return(authenticatable)
        expect(authenticatable).to receive(:authenticate)
          .with(:a_password)
          .and_return(true)

        Credentialing.new(
          :a_controller,
          email: :an_email, password: :a_password
        ).log_in(
          success: lambda do |user_id|
            @success_called = true
            @user_id = user_id
          end
        )

        expect(@user_id).to eq :the_user_id
        expect(@success_called).to eq true
      end

      it 'Calls failure if the User::Member exists and can not authenticate' do
        expect(User::Member).to receive(:find_by_email)
          .with(:an_email)
          .and_return(unauthenticatable)
        expect(unauthenticatable).to receive(:authenticate)
          .with(:a_password)
          .and_return(false)

        Credentialing.new(
          :a_controller,
          email: :an_email, password: :a_password
        ).log_in(
          failure: lambda do
            @failure_called = true
          end
        )

        expect(@failure_called).to eq true
      end

      it 'Calls failure if the user does not exist' do
        expect(User::Member).to receive(:find_by_email)
          .with(:an_email)
          .and_return(missing)
        expect(missing).to receive(:authenticate)
          .with(:a_password)
          .and_return(false)

        Credentialing.new(
          :a_controller,
          email: :an_email, password: :a_password
        ).log_in(
          failure: lambda do
            @failure_called = true
          end
        )

        expect(@failure_called).to eq true
      end
    end
  end
end
