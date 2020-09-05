class NotesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_note, only: [:update, :destroy]

  def index
    notes = if params[:tags].blank?
              current_user.notes.includes(:user, :tags).order_by_date
            else
              current_user.notes.tagged_with(params[:tags].split(","), :any => true).includes(:user, :tags).order_by_date
            end

    if params[:search].present?
      notes = notes.search(params[:search])
    end
    notes = notes.paginate(page: params[:page], per_page: 12)
    options = {}
    options[:include] = [:user]
    render json: {
      data: NoteSerializer.new(notes, options).serializable_hash,
      total: notes.count
    }, status: :ok
  end

  def create
    note = current_user.notes.new(note_params)
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
      params.require(:note).permit(:title, :body, :tag_list => [])
    end
end
