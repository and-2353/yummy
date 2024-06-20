# db/migrate/20240620030636_create_tweets.rb
class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.text :text
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
