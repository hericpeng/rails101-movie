class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
   validates :title, presence: true

   has_many :favorites
   has_many :fans, through: :favorites, source: :user

end
