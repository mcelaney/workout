# Makes fixture methods available to feature specs
#
module FixtureMethods
  # Query: Returns a new User::Member
  #
  # @params [Hash]
  # @return [User::Member]
  #
  def get_user_member(params = {})
    User::Member.new(
      {
        email: params.fetch(:email, "user#{User::Member.count}@example.com"),
        password: params.fetch(:password, 'password'),
        password_confirmation: params.fetch(:password, 'password')
      }.merge(params.except(:email, :password))
    )
  end

  # Command: Creates a user and sets the user_id in session to the user's id
  #
  # @params [Hash]
  # @return [self]
  #
  def create_current_user(params = {})
    @_current_user = get_user_member(params)
    @_current_user.save!
    page.set_rack_session(user_id: @_current_user.id)
    self
  end
end
