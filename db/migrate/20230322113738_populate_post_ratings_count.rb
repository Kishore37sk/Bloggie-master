class PopulatePostRatingsCount < ActiveRecord::Migration[6.1]
  def change
    Post.all.each do |post|
      Post.reset_counters(post.id, :ratings)
    end
  end
end
