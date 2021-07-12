class Group < ActiveRecord::Base
    has_many :user_groups
    has_many :users, through: :user_groups
    has_many :group_movies
    has_many :movies, through: :group_movies

    def winning_movie
        #some logic here
    end
end