json.extract! glossary, :id, :title, :content

if @includes.present? && @includes.include?("vocabularies")
  json.vocabularies glossary.vocabularies, partial: "shared/vocabulary", as: :vocabulary
end

json.vocabularies_stats glossary.vocabularies_stats(@current_user)
