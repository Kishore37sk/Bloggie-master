class AddRatingAverageToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :rating_average, :integer
  end
end
