class Group < ActiveRecord::Base
    has_many :user_groups
    has_many :users, through: :user_groups
    has_many :group_movies
    has_many :movies, through: :group_movies
    has_many :votes, through: :user_groups

    def winning_movie
        round_1 = votes.where(rank: 1)
        round_1_count = round_1.group(:movie_id).count

        # x-way tie
        round_1_max = round_1_count.values.max
        round_1_max_hash = round_1_count.select {|k, v| v==round_1_max}
        if round_1_max_hash.values.sum == users.count
            winnerID = round_1_max_hash.keys.sample
            self.update(winner: winnerID)
            return Movie.find(winnerID)
        end

        round_1_top = round_1_count.max_by{|k, v| v}
        if round_1_top[1] > users.count/2
            winnerID = round_1_top[0]
            self.update(winner: winnerID)
            return Movie.find(winnerID)
        else
            smallest_amount = round_1_count.min_by{|k, v| v}[1]
            losers = round_1_count.select {|k, v| v == smallest_amount }.keys
            elim_users = []
            losers.each do |movie_id| 
                elim_votes = votes.where(movie_id: movie_id)
                elim_votes.each do |vote| 
                    vote.update(eliminated: true)
                    elim_users << vote.user_group_id
                end
            end
            # survivors = votes.where(rank: 1, eliminated: nil)
            # rank_twos = []
            # elim_users.each {|user| rank_twos << votes.find_by(user_group_id: user, rank: 2)}
            # round_2 = [*survivors, *rank_twos]
            round_2 = user_groups.map {|user| user.votes.where(eliminated: nil).first}
            round_2_count = round_2.group_by {|vote| vote.movie_id}
            round_2_hash = {}
            round_2_count.each {|k, v| round_2_hash[k] = v.count}

            # x-way tie
            round_2_max = round_2_hash.values.max
            round_2_max_hash = round_2_hash.select {|k, v| v==round_2_max}
            # if round_2_max_hash.count > 1 && round_2_max.to_f == user.count.to_f/2
            if round_2_max_hash.values.sum == user.count
                winnerID = round_2_max_hash.keys.sample
                self.update(winner: winnerID)
                return Movie.find(winnerID)
            end

            round_2_top = round_2_hash.max_by{|k, v| v}
            if round_2_top[1] > users.count/2
                winnerID = round_2_top[0]
                self.update(winner: winnerID)
                return Movie.find(winnerID)
            else
                smallest_amount = round_2_hash.min_by{|k, v| v}[1]
                losers = round_2_hash.select {|k, v| v == smallest_amount }.keys
                round_2_elim_users = []
                losers.each do |movie_id| 
                    elim_votes = votes.where(movie_id: movie_id)
                    elim_votes.each do |vote| 
                        vote.update(eliminated: true)
                        round_2_elim_users << vote.user_group_id
                    end
                end
                # survivors = votes.where(:rank => [1,2], eliminated: nil)
                # rank_threes = []
                # round_2_elim_users.each {|user| rank_threes << votes.find_by(user_group_id: user, rank: 3)}
                # round_3 = [*survivors, *rank_threes]
                round_3 = user_groups.map {|user| user.votes.where(eliminated: nil).first}
                round_3_count = round_3.group_by {|vote| vote.movie_id}
                round_3_hash = {}
                round_3_count.each {|k, v| round_3_hash[k] = v.count}

                # x-way tie
                round_3_max = round_3_hash.values.max
                round_3_max_hash = round_3_hash.select {|k, v| v==round_3_max}
                if round_3_max_hash.values.sum == user.count
                    winnerID = round_3_max_hash.keys.sample
                    self.update(winner: winnerID)
                    return Movie.find(winnerID)
                end

                round_3_top = round_3_hash.max_by{|k, v| v}
                winnerID = round_3_top[0]
                self.update(winner: winnerID)
                return Movie.find(winnerID)
            end
        end
        
    end
end