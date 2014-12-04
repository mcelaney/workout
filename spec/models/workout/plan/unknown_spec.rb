require File.dirname(__FILE__) + '/../../../../app/models/workout/plan/unknown'

# Workout domain
#
module Workout
  RSpec.describe Plan::Unknown do
    it 'provides NullObject instances' do
      expect(Plan::Unknown.new.is_a? NullObject).to eq true
    end
  end
end
