require 'rails_helper'

# Workout domain
#
module Workout
  RSpec.describe User::Member, type: :model do
    subject(:user) do
      User::Member.new(
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )
    end

    let(:email) { 'new_email@example.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    it { expect(user).to be_valid }

    describe 'associations' do
      it 'has many baselines' do
        expect(User::Member.reflect_on_association(:plans).macro)
          .to eq :has_many
      end
    end

    describe 'callbacks' do
      describe 'after_create' do
        it 'creates a plan for the user' do
          expect(::Workout::Plan::Baseline).to receive(:prepare_new_user)
            .with(user)
          user.save
        end
      end
    end

    describe 'class methods' do
      describe '.unknown_user' do
        it 'returns a User::Unknown instance' do
          expect(User::Member.unknown_user.class).to eq User::Unknown
        end
      end
    end

    describe 'finders' do
      context 'a user exists in the database' do
        before { user.save! }

        it '.find_by_email returns a user given the correct email' do
          expect(
            User::Member.find_by_email('new_email@example.com')
          ).to eq user
        end

        it '.find_by_id returns a user given the correct id' do
          expect(User::Member.find_by_id(user.id)).to eq user
        end
      end

      context 'a user does not exist in the database' do
        it '.find_by_email returns User::Unknown' do
          expect(User::Member.find_by_email('not the email').is_a? NullObject)
        end

        it '.find_by_id returns User::Unknown' do
          expect(User::Member.find_by_id('not the id').is_a? NullObject)
        end
      end
    end

    describe 'instance methods' do
      describe '.plan' do
        it 'returns the plan for the user' do
          expect(user.plan)
            .to eq Plan::Baseline.where(member_id: user.id).first
        end
      end

      describe '.started?' do
        it 'returns true if the associated plan returns true' do
          allow_any_instance_of(Workout::Plan::Baseline)
            .to receive(:started?).and_return(true)
          user.save!
          expect(user.started?).to eq true
        end

        it 'returns false if the associated plan returns false' do
          allow_any_instance_of(Workout::Plan::Baseline)
            .to receive(:started?).and_return(false)
          user.save!
          expect(user.started?).to eq false
        end
      end
    end

    describe 'validations' do
      context 'when password doesn\'t exist' do
        let(:password) { nil }

        it { expect(user).to_not be_valid }
        it 'dislays a missing value error' do
          user.valid?
          expect(user.errors[:password]).to include('can\'t be blank')
        end
      end

      context 'when email doesn\'t exist' do
        let(:email) { nil }

        it { expect(user).to_not be_valid }
        it 'dislays a missing value error' do
          user.valid?
          expect(user.errors[:email]).to include('can\'t be blank')
        end
      end

      context 'when email is a duplicate' do
        let!(:duplicate_user) do
          User::Member.create(
            email: email,
            password: password,
            password_confirmation: password_confirmation
          )
        end

        it { expect(user).to_not be_valid }
        it 'dislays a duplicate value error' do
          user.valid?
          expect(user.errors[:email]).to include('has already been taken')
        end
      end

      context 'when emails are formatted correctly' do
        %w(
          macdev@example.com
          mac+dev@example.com
          mac_dev@example.com
          mac+dev@mail.example.com
        ).each do |correct_email_format|
          let(:email) { correct_email_format }
          it { expect(user).to be_valid }
        end
      end

      context 'when emails are not formatted correctly' do
        %w(
          macdev@example
          macdevexample.com
        ).each do |incorrect_email_format|
          let(:email) { incorrect_email_format }
          it { expect(user).to_not be_valid }
        end
      end
    end
  end
end
