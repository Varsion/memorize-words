class CreateSentence < ActiveRecord::Migration[7.0]
  def change
    create_table :sentences do |t|
      t.string :content
      t.belongs_to :vocabulary

      t.timestamps
    end
  end
end
