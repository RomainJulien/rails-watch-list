class AddSummaryToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :summary, :text
  end
end
