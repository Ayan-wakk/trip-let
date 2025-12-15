# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|

      ## User introduction
      t.string :name
      t.text :introduction

      ## Database authenticatable
      t.string :email
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## OmniAuth
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, [:provider, :uid], unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
