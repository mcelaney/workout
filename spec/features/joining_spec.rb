require 'feature_helper'

RSpec.feature 'A user can create an account' do
  context 'An non-authenticated user' do
    let(:email) { 'user@workout.com' }
    let(:password) { 'password' }

    scenario 'can join the site' do
      visit root_url
      click_link I18n.t('navigation.sign_up')
      within('.user') do
        fill_in I18n.t('user.fields.email'), with: email
        fill_in I18n.t('user.fields.password'), with: password
        fill_in I18n.t('user.fields.confirmation'), with: password
      end
      click_button I18n.t('user.fields.join')
      expect(page).to have_content I18n.t('session.logged_in')
      click_link I18n.t('user.show')
    end

    scenario 'can not use an existing email' do
      user = get_user_member(email: email)
      user.save
      visit root_url
      click_link I18n.t('navigation.sign_up')
      within('.user') do
        fill_in I18n.t('user.fields.email'), with: user.email
        fill_in I18n.t('user.fields.password'), with: password
        fill_in I18n.t('user.fields.confirmation'), with: password
      end
      click_button I18n.t('user.fields.join')
      expect(page).to have_content 'Email has already been taken'
    end
  end

  context 'an authenticated user' do
    background { create_current_user }

    scenario 'can not create a new user' do
      visit new_user_path
      expect(page).to have_content I18n.t('session.must_not_be_authorized')
    end
  end
end

RSpec.feature 'A user can manage a profile' do
  context 'an authenticated user' do
    background { create_current_user }

    let(:email) { 'user@workout.com' }

    scenario 'can not view another user\'s profile'  do
      user = get_user_member(email: 'repeat@email.com')
      user.save
      visit user_path(user)
      expect(page).to have_content I18n.t('session.not_authorized')
    end

    scenario 'succeeds for own profile' do
      visit root_url
      click_link I18n.t('user.show')
      expect(page).to_not have_content email
      click_link I18n.t('form.edit')
      within('.user') do
        fill_in I18n.t('user.fields.email'), with: email
      end
      click_button I18n.t('form.save')
      expect(page).to have_content email
    end

    scenario 'succeeds for own profile' do
      user = get_user_member(email: 'repeat@email.com')
      user.save
      visit root_url
      click_link I18n.t('user.show')
      expect(page).to_not have_content email
      click_link I18n.t('form.edit')
      within('.user') do
        fill_in I18n.t('user.fields.email'), with: 'repeat@email.com'
      end
      click_button I18n.t('form.save')
      expect(page).to have_content 'Email has already been taken'
    end
  end
end
