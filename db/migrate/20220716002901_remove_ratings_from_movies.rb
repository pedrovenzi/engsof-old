class RemoveRatingsFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :ratings, :string
  end
end
