require 'feature_helper'

RSpec.feature 'A user can attempt log in' do
  let(:email) { 'user@workout.com' }
  let(:password) { 'password' }
  let(:user) { get_user_member(email: email, password: password) }

  scenario 'succeeds with correct credentials' do
    user.save!
    visit root_url
    click_link I18n.t('navigation.sign_in')
    within('.session') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
    end
    click_button 'Log in'
    expect(page).to have_content I18n.t('session.logged_in')
  end

  scenario 'fails with incorrect credentials' do
    visit log_in_path
    within('.session') do
      fill_in 'Email', with: email
      fill_in 'Password', with: 'not the password'
    end
    click_button 'Log in'
    expect(page).to have_content I18n.t('session.invalid')
  end
end

RSpec.feature 'A user can attempt log out' do
  background { create_current_user }

  scenario 'succeeds when logged in' do
    visit root_url
    click_link I18n.t('navigation.sign_out')
    expect(page).to have_content I18n.t('session.logged_out')
  end
end
