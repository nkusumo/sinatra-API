class Group < ActiveRecord::Base
    has_many :user_groups
    has_many :users, through: :user_groups
    has_many :group_movies
    has_many :movies, through: :group_movies
    has_many :votes, through: :user_groups

    def winning_movie
        round_1 = votes.where(rank: 1)
        round_1_count = round_1.group(:movie_id).count
        round_1_top = round_1_count.max_by{|k, v| v}
        if round_1_top[1] > users.count/2
            Movie.find(round_1_top[0])
        else
        end
        
    end
end