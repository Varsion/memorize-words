class AddTranslationToSentence < ActiveRecord::Migration[7.0]
  def change
    add_column :sentences, :translation, :string, null: false
  end
end
