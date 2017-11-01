class CreateTweetTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_tags do |t|
      t.integer :tag_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
