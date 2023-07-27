json.extract! glossary, :id, :title, :content

json.vocabularies glossary.vocabularies, partial: "shared/vocabulary", as: :vocabulary

json.vocabularies_stats glossary.vocabularies_stats(@current_user)
