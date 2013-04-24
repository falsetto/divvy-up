class CreateBucketGroups < ActiveRecord::Migration
  def change
    create_table :bucket_groups do |t|
      t.float :amount
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
