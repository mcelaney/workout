# View model for system users
#
class User
  include ActiveModel::Model

  delegate :email, :id, :errors, :password, :password_confirmation, to: :@model

  def initialize(user_instance)
    @model = user_instance
  end
end
