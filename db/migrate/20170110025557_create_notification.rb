class CreateNotification < ActiveRecord::Migration[5.0]
  def change
    drop_table :notifications, if_exists: true
    create_table :notifications do |t|
      t.references :receiver, polymorphic: true, index: true
      t.references :publisher
      t.integer :state, default: 0
      t.string :title
      t.string :body, limit: 5000
      t.string :link
      t.datetime :sent_at
      t.string :sent_code
      t.string :sent_result
      t.datetime :read_at, index: true
      t.string :notifiable_type
      t.integer :notifiable_id
      t.datetime :sending_at
      t.timestamps
    end
  end
end
