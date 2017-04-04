class CreateMovieCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_collections do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
  end
end
