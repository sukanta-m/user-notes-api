require "rails_helper"

RSpec.describe Users::RegistrationsController, :type => :api do
  let(:valid_attributes) { {registration: { first_name: "first_name", last_name: "last_name", email: "example@gmail.com", password: "password", password_confirmation: "password" }} }
  let(:invalid_attributes) { {registration: { first_name: "first_name", last_name: "last_name", email: "example@gmail.com", password: "", password_confirmation: "password" }} }
  
  describe "POST #create" do
    context "with valid attributes" do
      it "create new user" do
        expect {
          post "/signup", valid_attributes
        }.to change(User, :count).by(1)
      end

      it "returns http status 200" do
        post "/signup", valid_attributes
        expect(last_response.status).to eq(200)
      end

      it "return user details with auth token" do
        post "/signup", valid_attributes
        body = JSON.parse(last_response.body)
        expect(body["data"]["id"].to_i).to eq User.first.id
        expect(body["auth_token"]).to be_present
      end
    end

    context "with invalid attributes" do
      it "does not save the new note in the database" do
        expect {
          post "/signup", invalid_attributes
        }.not_to change(User, :count)
      end

      it "should return error if user already exist" do
        user = create(:user, valid_attributes["registration"])
        post "/signup", invalid_attributes
        body = JSON.parse(last_response.body)
        expect(body["errors"]).to be_present
      end

      it "returns http status 401" do
        post "/signup", invalid_attributes
        expect(last_response.status).to be(401)
      end
    end
  end
end