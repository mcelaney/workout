require 'feature_helper'

RSpec.feature 'A user can set up a workout plan' do
  let(:bench_press) { 100 }
  let(:bench_press) { 100 }
  let(:lat_pull) { 100 }
  let(:deadlift) { 100 }
  let(:military_press) { 100 }
  let(:one_arm_row) { 100 }
  let(:curls) { 100 }
  let(:squats) { 100 }
  let(:dips) { 100 }
  let(:pullups) { 100 }

  context 'There is no current user' do
    scenario 'Access is denied' do
      visit user_path(1)
      expect(page).to have_content I18n.t('session.not_authorized')
    end
  end

  context 'I am a member' do
    before(:each) { create_current_user }

    scenario 'I can set a workout default' do
      visit root_url
      click_link I18n.t('user.show')
      within('.defaults') do
        fill_in I18n.t('workout.fields.bench_press'), with: bench_press
      end
      click_button I18n.t('form.save')
      expect(page).to have_content I18n.t('user.updated')
      expect(Workout::User::Member.last.plan.bench_press).to eq bench_press
      expect(page).to_not have_content 'I am a workout'
    end

    scenario 'I can start a workout by setting all defaults' do
      visit root_url
      click_link I18n.t('user.show')
      within('.defaults') do
        fill_in I18n.t('workout.fields.bench_press'), with: bench_press
        fill_in I18n.t('workout.fields.lat_pull'), with: lat_pull
        fill_in I18n.t('workout.fields.deadlift'), with: deadlift
        fill_in I18n.t('workout.fields.military_press'), with: military_press
        fill_in I18n.t('workout.fields.one_arm_row'), with: one_arm_row
        fill_in I18n.t('workout.fields.curls'), with: curls
        fill_in I18n.t('workout.fields.squats'), with: squats
        fill_in I18n.t('workout.fields.dips'), with: dips
        fill_in I18n.t('workout.fields.pullups'), with: pullups
      end
      click_button I18n.t('form.save')
      expect(page).to have_content I18n.t('user.updated')
      expect(Workout::User::Member.last.plan.bench_press).to eq bench_press
      expect(page).to have_content 'I am a workout'
    end

    scenario 'I see an error if a non-integer is entered for a default' do
      visit root_url
      click_link I18n.t('user.show')
      within('.defaults') do
        fill_in I18n.t('workout.fields.bench_press'), with: 'string value'
      end
      click_button I18n.t('form.save')
      expect(page).to have_content I18n.t('form.errors.whole_number')
    end
  end
end
