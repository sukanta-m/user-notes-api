class NoteSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :title, :body, :tags, :created_at
  belongs_to :user
end
