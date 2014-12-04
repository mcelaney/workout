require 'rails_helper'

RSpec.describe I18n do
  describe 'form keys' do
    it 'exist' do
      expect(translation_exists?(I18n.t('form.save'))).to eq true
      expect(translation_exists?(I18n.t('form.edit'))).to eq true
      expect(translation_exists?(I18n.t('form.errors.whole_number'))).to eq true
    end
  end

  describe 'navigation_keys' do
    it 'exist' do
      expect(translation_exists?(I18n.t('navigation.sign_out'))).to eq true
      expect(translation_exists?(I18n.t('navigation.sign_in'))).to eq true
      expect(translation_exists?(I18n.t('navigation.sign_up'))).to eq true
    end
  end

  describe 'session keys' do
    it 'exist' do
      expect(translation_exists?(I18n.t('session.title'))).to eq true
      expect(translation_exists?(I18n.t('session.logged_out'))).to eq true
      expect(translation_exists?(I18n.t('session.logged_in'))).to eq true
      expect(translation_exists?(I18n.t('session.invalid'))).to eq true
      expect(translation_exists?(I18n.t('session.not_authorized'))).to eq true
      expect(translation_exists?(
        I18n.t('session.must_not_be_authorized'))
      ).to eq true
    end
  end

  describe 'user keys' do
    it 'exist' do
      expect(translation_exists?(I18n.t('user.title'))).to eq true
      expect(translation_exists?(I18n.t('user.show'))).to eq true
      expect(translation_exists?(I18n.t('user.updated'))).to eq true
      expect(translation_exists?(I18n.t('user.fields.email'))).to eq true
      expect(translation_exists?(I18n.t('user.fields.password'))).to eq true
      expect(translation_exists?(I18n.t('user.fields.confirmation'))).to eq true
      expect(translation_exists?(I18n.t('user.fields.join'))).to eq true
    end
  end

  describe 'workout keys' do
    it 'exist' do
      expect(translation_exists?(
        I18n.t('workout.fields.bench_press'))
      ).to eq true
      expect(translation_exists?(I18n.t('workout.fields.lat_pull'))).to eq true
      expect(translation_exists?(I18n.t('workout.fields.deadlift'))).to eq true
      expect(translation_exists?(
        I18n.t('workout.fields.military_press'))
      ).to eq true
      expect(translation_exists?(
        I18n.t('workout.fields.one_arm_row'))
      ).to eq true
      expect(translation_exists?(I18n.t('workout.fields.curls'))).to eq true
      expect(translation_exists?(I18n.t('workout.fields.squats'))).to eq true
      expect(translation_exists?(I18n.t('workout.fields.dips'))).to eq true
      expect(translation_exists?(I18n.t('workout.fields.pullups'))).to eq true
    end
  end

  private

  def translation_exists?(string)
    !string.include?('translation missing:')
  end
end
