class Movie < ApplicationRecord
  belongs_to :user
  has_many :review 
  validates :name, presence: true
end
