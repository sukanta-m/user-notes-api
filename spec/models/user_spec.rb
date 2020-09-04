require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, title: "My Note", tag_list: "demo, note", user: user) }

  describe "association" do
    it "should have notes" do
      expect(user.notes).to eq([note])
    end
  end
end