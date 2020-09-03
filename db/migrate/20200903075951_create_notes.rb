class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title, null: false, default: ""
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
