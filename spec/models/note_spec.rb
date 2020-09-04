require "rails_helper"

RSpec.describe Note, type: :model do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, title: "My Note", tag_list: "demo, note", user: user) }

  describe "validation" do
    context "when title is not present" do
      it "should not validate the note" do
        expect(FactoryBot.build(:note, title: "")).to_not be_valid
      end
    end

    context "when title is taken for same user" do
      it "should not validate the note" do
        expect(FactoryBot.build(:note, title: "My Note", user: user)).to_not be_valid
      end
    end

    context "when title and body is present and title is not taken" do
      it "should validate the note" do
        expect(FactoryBot.build(:note, title: "Personal Note", user: user)).to be_valid
      end
    end
  end

  describe "#display_tags" do
    it "should return tags" do
      expect(note.tag_list).to eq(["demo", "note"])
    end
  end

  describe "#search" do
    context "when passing no search params" do
      it "should return note" do
        expect(user.notes.search(nil)).to eq([note])
      end
    end

    context "when passing valid search params" do
      it "should return note with this keyword" do
        expect(user.notes.search("Note")).to eq([note])
      end
    end

    context "when passing invalid search params" do
      it "should return no note with this keyword" do
        expect(user.notes.search("hello Note")).to eq([])
      end
    end
  end
end