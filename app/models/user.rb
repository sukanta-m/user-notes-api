class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name
  has_many :notes, foreign_key: :user_id
end
