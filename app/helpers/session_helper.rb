# View helper for session-related functionality
#
module SessionHelper
  # Returns a link to the current session management option - login or logout
  #
  # @return [String]
  #
  def authentication_link
    return link_to I18n.t('navigation.sign_out'), log_out_path if current_user?
    link_to I18n.t('navigation.sign_in'), log_in_path
  end

  # Returns a link to the current account management option - create or show
  #
  # @return [String]
  #
  def account_link
    return link_to I18n.t('user.show'), user_path(current_user) if current_user?
    link_to I18n.t('navigation.sign_up'), new_user_path
  end
end
