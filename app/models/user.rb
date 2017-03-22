class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :movies
    has_many :reviews
    has_many :favorites
    has_many :favorited_movies, through: :favorites, source: :movie

    def is_fan_of?(movie)
        favorited_movies.include?(movie)
    end

    def join!(movie)
        favorited_movies << movie
    end

    def quit!(movie)
        favorited_movies.delete(movie)
    end
end
