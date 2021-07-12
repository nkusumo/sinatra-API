class Vote < ActiveRecord::Base
    belongs_to :user_group
    belongs_to :movie
end