class JoinTableRelationships < ActiveRecord::Migration[7.0]
  def change
    create_join_table :followers, :followeds, table_name: :relationships do |t|
      t.index [:follower_id, :followed_id]
      t.index :followed_id
    end
  end
end
