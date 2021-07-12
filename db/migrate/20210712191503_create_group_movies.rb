class CreateGroupMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :group_movies do |t|
      t.integer :group_id
      t.integer :movie_id
    end
  end
end
