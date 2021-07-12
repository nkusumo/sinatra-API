class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_group_id
      t.integer :movie_id
      t.integer :rank
    end
  end
end
