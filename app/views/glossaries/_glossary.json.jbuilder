json.extract! glossary, :id, :title, :content

json.vocabularies glossary.vocabularies, partial: "shared/vocabulary", as: :vocabulary
