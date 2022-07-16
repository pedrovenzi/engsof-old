class AddRatingsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :ratings, :string
  end
end
