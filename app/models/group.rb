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
            smallest_amount = round_1_count.min_by{|k, v| v}[1]
            losers = round_1_count.select {|k, v| v == smallest_amount }.keys
            elim_users = []
            losers.each do |movie_id| 
                elim_votes = votes.where(movie_id: movie_id, rank: 1)
                elim_votes.each do |vote| 
                    vote.update(eliminated: true)
                    elim_users << vote.user_group_id
                end
            end
            survivors = votes.where(rank: 1, eliminated: nil)
            rank_twos = []
            elim_users.each {|user| rank_twos << votes.find_by(user_group_id: user, rank: 2)}
            round_2 = [*survivors, *rank_twos]
            binding.pry
            round_2_count = round_2.group_by {|vote| vote.movie_id}
            round_2_hash = {}
            round_2_count.each {|k, v| round_2_hash[k] = v.count}
            round_2_top = round_2_hash.max_by{|k, v| v}
            if round_2_top[1] > users.count/2
                Movie.find(round_2_top[0])
            else
                smallest_amount = round_2_hash.min_by{|k, v| v}[1]
                losers = round_2_hash.select {|k, v| v == smallest_amount }.keys
                elim_users = []
                losers.each do |movie_id| 
                    elim_votes = votes.where(movie_id: movie_id, :rank => [1,2]) # OR rank 2
                    elim_votes.each do |vote| 
                        vote.update(eliminated: true)
                        elim_users << vote.user_group_id
                    end
                end
                survivors = votes.where(:rank => [1,2], eliminated: nil) # OR rank 2
                rank_threes = []
                elim_users.each {|user| rank_threes << votes.find_by(user_group_id: user, rank: 3)}
                round_3 = [*survivors, *rank_threes]
                round_3_count = round_3.group_by {|vote| vote.movie_id}
                round_3_hash = {}
                round_3_count.each {|k, v| round_3_hash[k] = v.count}
                round_3_top = round_3_hash.max_by{|k, v| v}
                Movie.find(round_3_top[0])
            end
        end
        
    end
end