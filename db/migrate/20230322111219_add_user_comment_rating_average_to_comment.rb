class AddUserCommentRatingAverageToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :ucr_avg, :float
  end
end
