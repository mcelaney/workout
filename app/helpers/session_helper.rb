# View helper for session-related functionality
#
module SessionHelper
  def authentication_link
    if current_user?
      link_to I18n.t('navigation.sign_out'), log_out_path
    else
      link_to I18n.t('navigation.sign_in'), log_in_path
    end
  end
end
