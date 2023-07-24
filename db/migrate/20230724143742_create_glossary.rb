class CreateGlossary < ActiveRecord::Migration[7.0]
  def change
    create_table :glossaries do |t|
      t.string :title, null: false
      t.text :content
      # can add or remove words
      t.boolean :is_system, default: false

      t.timestamps
    end
  end
end