class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.belongs_to :post
      t.integer :value, default: nil
      t.timestamps
    end
  end
end
