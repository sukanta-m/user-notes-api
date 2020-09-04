require "rails_helper"

RSpec.describe NotesController, :type => :api do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, user: user, title: "title note", body: "body note") }

  describe "GET index" do
    it "requires login" do
      get "/notes"
      body = JSON.parse(last_response.body)
      expect(last_response.status).to eq(401)
      expect(body["error"]).to be_present
    end

    it "returns http status 200" do
      auth_setup(user)
      get "/notes"
      expect(last_response.status).to eq(200)
    end

    it "returns array of notes" do
      auth_setup(user)
      get "/notes"
      body = JSON.parse(last_response.body)
      expect(body["data"].length).to eq 1
    end

    it "return search record" do
      auth_setup(user)
      get "/notes", {search: "note1"}
      body = JSON.parse(last_response.body)
      expect(body["data"].length).to eq 0
    end
  end

  describe "POST #create" do
    it "requires login" do
      post "/notes", {note: { title: "Hello World", body: "How are you?" }, tag_list: ["tag1"]}
      body = JSON.parse(last_response.body)
      expect(last_response.status).to eq(401)
      expect(body["error"]).to be_present
    end

    context "with valid attributes" do
      it "saves the new note in the database" do
        auth_setup(user)
        expect {
          post "/notes", {note: { title: "Hello World", body: "How are you?" }, tag_list: ["tag1"]}
        }.to change(user.notes, :count).by(1)
      end

      it "returns http status 201" do
        auth_setup(user)
        post "/notes", {note: { title: "Hello World", body: "How are you?" }, tag_list: ["tag1"]}
        expect(last_response.status).to eq(201)
      end

      it "return note data" do
        auth_setup(user)
        post "/notes", {note: { title: "Hello World", body: "How are you?" }, tag_list: ["tag1"]}
        body = JSON.parse(last_response.body)
        expect(body["data"]["id"].to_i).to eq user.notes.last.id
      end
    end

    context "with invalid attributes" do
      it "does not save the new note in the database" do
        auth_setup(user)
        expect {
          post "/notes", {note: { title: "", body: "How are you?" }, tag_list: ["tag1"]}
        }.not_to change(user.notes, :count)
      end

      it "returns http status 422" do
        auth_setup(user)
        post "/notes", {note: { title: "", body: "How are you?" }, tag_list: ["tag1"]}
        expect(last_response.status).to be(422)
      end
    end
  end

  describe "PUT #update" do
    it "requires login" do
      put "/notes/#{note.id}", { id: note.id, note: { title: "Hello World", body: "How are you?" }}
      body = JSON.parse(last_response.body)
      expect(last_response.status).to eq(401)
      expect(body["error"]).to be_present
    end

    context "with valid attributes" do
      it "updates the requested note" do
        auth_setup(user)
        put "/notes/#{note.id}", { id: note.id, note: { title: "Hello World", body: "How are you?" }}
        note.reload
        expect(note.title).to eq("Hello World")
        expect(note.body).to eq("How are you?")
      end

      it "returns http status 201" do
        auth_setup(user)
        put "/notes/#{note.id}", { id: note.id, note: { title: "Hello World", body: "How are you?" }}
        expect(last_response.status).to be(201)
      end
    end

    context "with invalid attributes" do
      it "does not update the requested note" do
        auth_setup(user)
        expect {
          put "/notes/#{note.id}", { id: note.id, note: { title: "", body: "How are you?" }}
        }.not_to change { note.reload.attributes }
      end

      it "returns http status 422" do
        auth_setup(user)
        put "/notes/#{note.id}", { id: note.id, note: { title: "", body: "How are you?" }}
        expect(last_response.status).to be(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "requires login" do
      delete "/notes/#{note.id}"
      body = JSON.parse(last_response.body)
      expect(last_response.status).to eq(401)
      expect(body["error"]).to be_present
    end

    it "returns http status 302" do
      auth_setup(user)
      delete "/notes/#{note.id}"
      expect(last_response.status).to be(200)
    end

    it "deletes the note" do
      auth_setup(user)
      expect{
        delete "/notes/#{note.id}"
      }.to change(Note, :count).by(-1)
    end
  end
end