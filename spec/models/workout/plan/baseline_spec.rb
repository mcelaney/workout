require 'rails_helper'

# Workout domain
#
module Workout
  RSpec.describe Plan::Baseline, type: :model do
    subject(:plan) do
      Plan::Baseline.new(
        member_id: member_id,
        bench_press: bench_press,
        lat_pull: lat_pull,
        deadlift: deadlift,
        military_press: military_press,
        one_arm_row: one_arm_row,
        curls: curls,
        squats: squats,
        dips: dips,
        pullups: pullups
      )
    end

    let(:member) { get_user_member.tap(&:save) }
    let(:member_id) { member.try(:id) }
    let(:bench_press) { nil }
    let(:lat_pull) { nil }
    let(:deadlift) { nil }
    let(:military_press) { nil }
    let(:one_arm_row) { nil }
    let(:curls) { nil }
    let(:squats) { nil }
    let(:dips) { nil }
    let(:pullups) { nil }

    it { expect(plan).to be_valid }

    describe 'associations' do
      it 'belongs to a user' do
        expect(Plan::Baseline.reflect_on_association(:member).macro)
          .to eq :belongs_to
      end
    end

    describe 'class methods' do
      # @todo - make this spec less of a hack
      #
      describe '.prepare_new_user_handler' do
        it 'adds a plan to the user' do
          Plan::Baseline.prepare_new_user(member)
          expect(member.plans.count).to eq 2
        end
      end

      describe '.unknown_plan' do
        it 'returns a User::Unknown instance' do
          expect(Plan::Baseline.unknown_plan.class).to eq Plan::Unknown
        end
      end
    end

    describe 'constants' do
      it 'inclde EXERCISES' do
        expect(Workout::Plan::Baseline::EXERCISES.is_a?(Array)).to eq true
      end
    end

    describe 'instance methods' do
      describe '.started?' do
        context 'all defaults have been set' do
          it 'returns true' do
            expect(plan).to receive(:all_defaults_set?).and_return(true)
            expect(plan.started?).to eq true
          end
        end

        context 'not all defaults have been set' do
          it 'returns false' do
            expect(plan).to receive(:all_defaults_set?).and_return(false)
            expect(plan.started?).to eq false
          end
        end
      end

      describe '.all_defaults_set?' do
        context 'all defaults are set' do
          before(:each) do
            plan.assign_attributes(
              Hash[Workout::Plan::Baseline::EXERCISES.map { |key| [key, 100] }]
            )
          end

          it 'returns true' do
            expect(plan.all_defaults_set?).to eq true
          end
        end

        context 'no defaults are set' do
          it 'returns false' do
            expect(plan.all_defaults_set?).to eq false
          end
        end

        context 'some but not all are set' do
          before(:each) do
            plan.assign_attributes(
              Hash[Workout::Plan::Baseline::EXERCISES[1..-1]
                .map { |key| [key, 100] }]
            )
          end

          it 'returns false' do
            expect(plan.all_defaults_set?).to eq false
          end
        end
      end
    end

    describe 'validations' do
      context 'when member is missing' do
        let(:member_id) { nil }

        it { expect(plan).to_not be_valid }
        it 'dislays a missing value error' do
          plan.valid?
          expect(plan.errors[:member_id]).to include('can\'t be blank')
        end
      end
      # @todo Dry up the following specs
      context 'when bench_press is not an integer' do
        let(:bench_press) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:bench_press])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when lat_pull is not an integer' do
        let(:lat_pull) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:lat_pull])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when deadlift is not an integer' do
        let(:deadlift) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:deadlift])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when military_press is not an integer' do
        let(:military_press) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:military_press])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when one_arm_row is not an integer' do
        let(:one_arm_row) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:one_arm_row])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when curls is not an integer' do
        let(:curls) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:curls])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when squats is not an integer' do
        let(:squats) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:squats])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when dips is not an integer' do
        let(:dips) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:dips])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end

      context 'when pullups is not an integer' do
        let(:pullups) { 'not an integer' }

        it { expect(plan).to_not be_valid }
        it 'displays a blerg error' do
          plan.valid?
          expect(plan.errors[:pullups])
            .to include(I18n.t('form.errors.whole_number'))
        end
      end
    end
  end
end
