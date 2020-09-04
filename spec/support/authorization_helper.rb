module AuthorizationHelper
  def auth_setup(user)
    token = JsonWebToken.encode({user_id: user.id})
    header "Authorization", "Bearer #{token}"
  end
end