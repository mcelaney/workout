require File.dirname(__FILE__) + '/../../../../app/models/workout/user/unknown'

# Workout domain
#
module Workout
  RSpec.describe User::Unknown do
    it 'provides NullObject instances' do
      expect(User::Unknown.new.is_a? NullObject).to eq true
    end

    describe 'authenticate' do
      it 'always returns false' do
        expect(User::Unknown.new.authenticate('password')).to eq false
      end
    end

    describe 'errors' do
      it 'always returns empty array' do
        expect(User::Unknown.new.errors).to eq []
      end
    end

    describe 'other values' do
      it 'are nil' do
        expect(User::Unknown.new.email).to be_nil
        expect(User::Unknown.new.id).to be_nil
      end
    end
  end
end
