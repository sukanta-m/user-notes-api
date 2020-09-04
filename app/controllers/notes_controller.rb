class NotesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_note, only: [:update, :destroy]

  def index
    notes = current_user.notes.includes(:user, :tags).by_join_date
    options = {}
    options[:include] = [:user]
    render json: NoteSerializer.new(notes, options).serializable_hash, status: :ok
  end

  def create
    note = current_user.notes.new(note_params)
    note.tag_list = params[:tag_list].join(",")
    if note.save
      render json: NoteSerializer.new(note, {include: [:user]}).serializable_hash, status: :created
    else
      render json: note.errors.full_messages.join(", "), status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      render json: NoteSerializer.new(@note, {include: [:user]}).serializable_hash, status: :created
    else
      render json: @note.errors.full_messages.join(", "), status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    render json: @note.id, status: :ok
  end

  def tags
    render json: Note.tag_counts.collect { |tag| tag.name }
  end

  private
    def set_note
      @note = current_user.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :body)
    end
end
