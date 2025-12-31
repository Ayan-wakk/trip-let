class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :country
      t.string :region
      t.date :visited_at
      t.text :warning
      t.boolean :is_public, default: true, null: false

      t.timestamps
    end
  end
end
