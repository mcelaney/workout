# Makes fixture methods available to feature specs
#
module FixtureMethods
  def get_user_member(params = {})
    User::Member.new(
      {
        email: params.fetch(:email, "user#{User::Member.count}@example.com"),
        password: params.fetch(:password, 'password'),
        password_confirmation: params.fetch(:password, 'password')
      }.merge(params.except(:email, :password))
    )
  end

  def create_current_user(params = {})
    @_current_user = get_user_member(params)
    @_current_user.save!
    page.set_rack_session(user_id: @_current_user.id)
  end
end
