class AddEliminatedToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :eliminated, :boolean
  end
end
