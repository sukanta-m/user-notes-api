# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, active: true
      else
        expire_data_after_sign_in!
        respond_with resource, active: false
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with_error
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

  def respond_with_error
    render json: { errors: "Failed to signup" }, :status => 401
  end

  def sign_up_params
    params.require(:registration).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
