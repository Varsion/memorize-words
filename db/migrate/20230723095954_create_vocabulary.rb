class CreateVocabulary < ActiveRecord::Migration[7.0]
  def change
    create_table :vocabularies do |t|
      t.string :display, null: false
      t.string :secondly_display
      t.text :description
      t.string :pronunciation, null: false

      t.integer :type, default: 0
      t.timestamps
    end
  end
end
