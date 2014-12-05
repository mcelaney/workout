# Controller to manage user information
#
class UsersController < ApplicationController
  include UserResponder

  delegate :create_member, :update_information, to: :joining

  before_filter :authorize, only: [:show, :edit, :update]
  before_filter :ensure_unathenticated, only: [:new, :create]
  before_filter :set_user_view_model, only: [:show, :edit, :update]

  # action: account page
  #
  def show
  end

  # action: Account signup form
  #
  def new
    @user = User.new(Workout::Joining.new_member)
  end

  # action: Create new user action
  #
  # Calls create_member on joining service. Sends success and failure lambdas
  # - success: calls user_creation_success private method to set the user_id in
  #   session and forward the user
  # - failure: calls user_creation_failure to re-render the account signup form
  #
  def create
    create_member(
      success: -> (user_id:) { creation_success(user_id: user_id) },
      failure: -> (user_model:) { creation_failure(user_model: user_model) }
    )
  end

  # action: Edit account form
  #
  def edit
  end

  # action: Update user action
  #
  # Calls update_information on joining service. Sends success and failure
  # - success: calls user_change_success private method to forward the user
  # - failure: calls user_change_failure to re-render the account edit form
  #
  def update
    update_information(
      success: -> (user_id:) { change_success(user_id: user_id) },
      failure: -> (user_model:) { change_failure(user_model: user_model) }
    )
  end

  private

  def joining
    Workout::Joining.new(self, user_params)
  end

  def request_for_current_user?
    current_user_is?(params[:id].to_i)
  end

  def set_user_view_model
    @user ||= User.new(current_user)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
