class Movie < ActiveRecord::Base
    has_many :group_movies
    has_many :groups, through: :group_movies
    has_many :votes
    has_many :user_groups, through: :votes
end