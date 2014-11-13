require 'rails_helper'

RSpec.describe I18n do
  describe 'session keys' do
    it 'exist' do
      expect(translation_exists?(I18n.t('session.logged_out'))).to eq true
      expect(translation_exists?(I18n.t('session.logged_in'))).to eq true
      expect(translation_exists?(I18n.t('session.invalid'))).to eq true
    end
  end

  describe 'navigation_keys' do
    it 'exist' do
      expect(translation_exists?(I18n.t('navigation.sign_out'))).to eq true
      expect(translation_exists?(I18n.t('navigation.sign_in'))).to eq true
    end
  end

  private

  def translation_exists?(string)
    !string.include?('translation missing:')
  end
end
