class AddLatLngToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
  end
end
