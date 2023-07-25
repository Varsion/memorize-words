class Glossary < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", required: false

  has_many :glossary_vocabularies
  has_many :vocabularies, through: :glossary_vocabularies

  def can_update?(user)
    !is_system && owner == user
  end

  def add_vocabularies(vocabulary_ids)
    vocs = Vocabulary.where(id: vocabulary_ids)
    vocabularies << vocs
  end
end
