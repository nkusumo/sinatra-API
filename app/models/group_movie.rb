class GroupMovie < ActiveRecord::Base
    belongs_to :movie
    belongs_to :group
end