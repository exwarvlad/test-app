class CreateIpAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_addresses do |t|
      t.inet :ip, null: false
      t.timestamps
    end
  end
end
