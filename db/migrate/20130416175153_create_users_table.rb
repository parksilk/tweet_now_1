class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_id
      t.string :twitter_username
      t.string :token
      t.string :secret
      t.timestamps
    end
  end
end
