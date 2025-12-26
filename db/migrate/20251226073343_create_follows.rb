class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.bigint :follower_id, null: false
      t.bigint :followed_id, null: false

      t.timestamps
    end

    # Tambahkan foreign key manual setelah create_table
    add_foreign_key :follows, :players, column: :follower_id
    add_foreign_key :follows, :players, column: :followed_id

    # Tambahkan index untuk performa
    add_index :follows, :follower_id
    add_index :follows, :followed_id
  end
end
