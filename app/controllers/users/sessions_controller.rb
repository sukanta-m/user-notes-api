# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def auto_login
    if current_user
      respond_with current_user
    else
      render json: { errors: "No user Logged in" }, :status => 401
    end
  end

  def create
    resource = User.find_for_database_authentication(email: params[:email])

    if resource && active_for_authentication?(resource)
      if invalid_for_authentication?(resource, params[:password])
        render json: {error: 'Invalid username / password'}, status: :unauthorized
      end

      respond_with(resource, active: true)
    else
      render json: {error: 'User is not yet registered'}, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    auth_token = JsonWebToken.encode({user_id: resource.id})
    render json: {
      auth_token: auth_token,
      status: {code: 200, message: 'Logged in successfully.', active: _opts[:active]},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end
  
  def respond_to_on_destroy
    head :ok
  end

  private

    def invalid_for_authentication?(resource, password)
      valid_password = resource.valid_password?(password)

      (resource.respond_to?(:valid_for_authentication?) && !resource.valid_for_authentication? { valid_password }) ||
        !valid_password
    end

    def active_for_authentication?(resource)
      !resource.respond_to?(:active_for_authentication?) || resource.active_for_authentication?
    end
end
