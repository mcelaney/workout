require File.dirname(__FILE__) + '/../../app/services/workout/joining'

# Workout domain
#
module Workout
  RSpec.describe Joining do
    describe '.new_member' do
      it 'calls Workout::User::Member.new' do
        expect(User::Member).to receive(:new)
        Joining.new_member
      end
    end

    describe '#create_member' do
      it 'Calls success if new_user is valid' do
        valid_user = double(valid?: true, save!: true, id: :the_user_id)
        expect(User::Member).to receive(:new)
          .with(email: :an_email, password: :a_password)
          .and_return(valid_user)

        Joining.new(
          :a_controller,
          email: :an_email, password: :a_password
        ).create_member(
          success: lambda do |user_id|
            @success_called = true
            @user_id = user_id
          end
        )

        expect(@user_id).to eq :the_user_id
        expect(@success_called).to eq true
      end

      it 'Calls failure if new_user is invalid' do
        invalid_user = double(valid?: false)
        expect(User::Member).to receive(:new)
          .with(email: :an_email, password: :a_password)
          .and_return(invalid_user)

        Joining.new(
          :a_controller,
          email: :an_email, password: :a_password
        ).create_member(
          failure: lambda do |user|
            @failure_called = true
            @user = user
          end
        )

        expect(@user).to eq invalid_user
        expect(@failure_called).to eq true
      end
    end

    describe '#update_information' do
      it 'Calls success if current_user is valid' do
        controller = double(
          current_user: double(
            assign_attributes: nil,
            valid?: true,
            save!: true,
            id: :the_user_id
          )
        )
        Joining.new(
          controller,
          email: :an_email, password: :a_password
        ).update_information(
          success: lambda do |user_id|
            @success_called = true
            @user_id = user_id
          end
        )

        expect(@user_id).to eq :the_user_id
        expect(@success_called).to eq true
      end

      it 'Calls failure if current_user is not valid' do
        current_user = double(
          assign_attributes: nil,
          valid?: false,
          id: :a_user
        )
        controller = double(
          current_user: current_user
        )
        Joining.new(
          controller,
          email: :an_email, password: :a_password
        ).update_information(
          failure: lambda do |user|
            @success_called = true
            @user = user
          end
        )

        expect(@user).to eq current_user
        expect(@success_called).to eq true
      end
    end
  end
end
