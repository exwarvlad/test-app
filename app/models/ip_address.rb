class IpAddress < ApplicationRecord
  has_many :posts, dependent: :restrict_with_exception
  has_many :users, -> { distinct }, through: :posts, source: 'user'

  validates :ip, presence: true

  scope :unique_address_multiple_use, -> do
    # NOTE: no pairs for [user_login, ip]
    # just ips.
    ActiveRecord::Base.
      connection.
      execute('SELECT ip from ip_addresses where id IN (select tbl.ip_address_id FROM ' \
              '(SELECT user_id, ip_address_id FROM posts ' \
              'GROUP BY ip_address_id, user_id) as tbl GROUP BY tbl.ip_address_id ' \
              'HAVING count(*) > 1 ORDER BY ip_address_id); ').
      values.
      flatten
  end

  delegate :login, to: :users
end
