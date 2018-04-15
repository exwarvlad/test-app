class ChangeDefaultPostsAverageRate < ActiveRecord::Migration[5.1]
  def change
    change_column_default :posts, :average_rate, from: nil, to: 0
    ActiveRecord::Base.connection.execute('UPDATE posts SET average_rate = 0 WHERE average_rate IS NULL')
  end
end
