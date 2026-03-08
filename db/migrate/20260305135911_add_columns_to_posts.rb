class AddColumnsToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :duration, :integer
    add_column :posts, :url, :string
    add_column :posts, :prefecture, :string
  end
end
