# View helper for user-related functionality
#
module UserHelper
  # Returns an optional edit link
  #
  # @param user_id [Integer]
  # @return [String]
  #
  def edit_user_link(user_id)
    return '' unless current_user_is?(user_id)
    link_to I18n.t('form.edit'), edit_user_path(user_id)
  end
end
