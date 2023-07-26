class CreateMarkLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :mark_logs do |t|
      t.integer :user_id, null: false
      t.integer :vocabulary_id, null: false
      t.integer :action, null: false

      t.timestamps
    end
  end
end
