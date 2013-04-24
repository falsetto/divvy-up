class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.float :percentage
      t.integer :priority
      t.integer :bucket_group_id

      t.timestamps
    end
  end
end
