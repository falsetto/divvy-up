class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.float :percentage
      t.integer :order
      t.integer :user_id

      t.timestamps
    end
  end
end
