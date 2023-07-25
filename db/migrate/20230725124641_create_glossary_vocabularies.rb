class CreateGlossaryVocabularies < ActiveRecord::Migration[7.0]
  def change
    create_table :glossary_vocabularies do |t|
      t.integer :glossary_id
      t.integer :vocabulary_id

      t.timestamps
    end
  end
end
