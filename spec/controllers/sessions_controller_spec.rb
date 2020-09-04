require "rails_helper"

RSpec.describe Users::SessionsController, :type => :api do
  let!(:user) { create(:user, email: "example@gmail.com", password: "password", password_confirmation: "password") }

  describe "GET #auto_login" do
    context "with valid attributes" do
      it "returns http status 200" do
        auth_setup(user)
        get "/user/auto_login"
        expect(last_response.status).to eq(200)
      end

      it "return user details with auth token" do
        auth_setup(user)
        get "/user/auto_login"
        body = JSON.parse(last_response.body)
        expect(body["data"]["id"].to_i).to eq User.first.id
        expect(body["auth_token"]).to be_present
      end
    end

    context "with invalid attributes" do
      it "returns http status 401" do
        get "/user/auto_login"
        expect(last_response.status).to be(401)
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "returns http status 200" do
        post "/login", {email: "example@gmail.com", password: "password"}
        expect(last_response.status).to eq(200)
      end

      it "return user details with auth token" do
        post "/login", {email: "example@gmail.com", password: "password"}
        body = JSON.parse(last_response.body)
        expect(body["data"]["id"].to_i).to eq User.first.id
        expect(body["auth_token"]).to be_present
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect {
          post "/login", {email: "example@gmail.com", password: "password1"}
        }.not_to change(User, :count)
      end

      it "returns http status 401" do
        post "/login", {email: "example@gmail.com", password: "password1"}
        expect(last_response.status).to be(401)
      end
    end
  end

  describe "DELETE #logout" do
    it "returns http status 200" do
      auth_setup(user)
      delete "/logout"
      expect(last_response.status).to eq(200)
    end
  end
end