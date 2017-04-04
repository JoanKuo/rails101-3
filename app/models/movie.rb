class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :name, presence: true

  has_many :movie_collections
  has_many :members, through: :movie_collections, source: :user
end
