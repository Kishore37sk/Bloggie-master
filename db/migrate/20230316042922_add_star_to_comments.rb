class AddStarToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :star, :integer
  end
end
