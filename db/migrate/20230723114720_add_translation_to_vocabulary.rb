class AddTranslationToVocabulary < ActiveRecord::Migration[7.0]
  def change
    add_column :vocabularies, :translation, :string, null: false
  end
end
