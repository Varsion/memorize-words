json.extract! vocabulary, :id, :display, :secondly_display, :translation, :description, :pronunciation, :language, :updated_at

json.learning_state vocabulary.user_state(@current_user.id)

json.sentences do
  json.array! vocabulary.sentences, partial: "shared/sentence", as: :sentence
end
