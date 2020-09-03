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
    user = User.find_by(email: params[:email].to_s.downcase)
  
    if user && user.authenticate(params[:password])
        auth_token = JsonWebToken.encode({user_id: user.id})
        render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: {code: 200, message: 'Logged in successfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }
  end
  
  def respond_to_on_destroy
    head :ok
  end
end
