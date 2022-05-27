class AddCachedLikesToTweets < ActiveRecord::Migration[7.0]
  def change
    change_table :tweets do |t|
      t.integer :cached_votes_total, default: 0
      t.integer :cached_votes_score, default: 0
      t.integer :cached_votes_up, defauult: 0
      t.integer :cached_votes_down, default: 0
      t.integer :cached_weighted_score, default: 0
      t.integer :cached_weighted_total, default: 0
      t.integer :cached_weighted_average, defauult: 0.0
    end
  end
end
