require 'rails_helper'

RSpec.describe User::Member, type: :model do
  let(:user_params) do
    {
      email: 'new_email@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:user) { User::Member.new user_params }

  it 'is valid with valid params' do
    expect(user).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a password' do
      user_params.delete :password
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('can\'t be blank')
    end

    it 'is invalid without an email' do
      user_params.delete :email
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('can\'t be blank')
    end

    it 'is invalid with a duplicate email' do
      user.save
      dup_user = User::Member.new user_params
      expect(dup_user).to_not be_valid
      expect(dup_user.errors[:email]).to include('has already been taken')
    end

    it 'does not accept bad email addresses' do
      %w(
        macdev@example.com
        mac+dev@example.com
        mac_dev@example.com
        mac+dev@mail.example.com
      ).each do |email|
        user.email = email
        expect(user).to be_valid
      end

      %w(
        macdev@example
        macdevexample.com
      ).each do |email|
        user.email = email
        expect(user).to_not be_valid
      end
    end
  end

  describe 'finders' do
    describe '.find_by_email' do
      context 'given a user exists' do
        before { user.save }

        it 'returns a user given the correct email' do
          expect(User::Member.find_by_email('new_email@example.com')).to eq user
        end

        it 'returns User::Unknown if given the incorrect email' do
          expect(User::Member.find_by_email('not the email').is_a? NullObject)
        end
      end
    end

    describe '.find_by_id' do
      context 'given a user exists' do
        before { user.save }

        it 'returns a user given the correct email' do
          expect(User::Member.find_by_id(user.id)).to eq user
        end

        it 'returns User::Unknown if given the incorrect id' do
          expect(User::Member.find_by_id('not the id').is_a? NullObject)
        end
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
end
