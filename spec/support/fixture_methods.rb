# Makes fixture methods available to feature specs
#
module FixtureMethods
  def get_user_member(args = {})
    User::Member.new(
      {
        email: args.fetch(:email, "user#{User::Member.count}@example.com"),
        password: args.fetch(:password, 'password'),
        password_confirmation: args.fetch(:password, 'password')
      }.merge(args.except(:email, :password))
    )
  end

  def create_current_user(args = {})
    @_current_user = get_user_member(args)
    @_current_user.save!
    page.set_rack_session(user_id: @_current_user.id)
  end
end
