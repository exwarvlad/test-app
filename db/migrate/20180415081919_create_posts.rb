class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.belongs_to :ip_address

      t.string     :title, null: false
      t.text       :description, null: false
      t.float      :average_rate
      t.timestamps
    end

    add_index :posts, :average_rate
  end
end
