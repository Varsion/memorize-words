class RenameTypeToLanguageFromVocabulary < ActiveRecord::Migration[7.0]
  def change
    rename_column :vocabularies, :type, :language
  end
end
