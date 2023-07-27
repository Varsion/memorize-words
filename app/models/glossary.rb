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

  def vocabularies_stats(user)
    learnings = vocabularies.left_joins(:mark_logs).where(mark_logs: { user_id: user.id })
    knowns = learnings.where(mark_logs: { action: "known" })
    {
      count: vocabularies.count,
      learning_count: learnings.count,
      known_count: knowns.count,
    }
  end

  # vocabularies order query

  def self.known_firstly_query
    "
      CASE
        WHEN mark_logs.id is NULL
          THEN 2
        WHEN mark_logs.action = 1
          THEN 1
        WHEN mark_logs.action = 0
          THEN 0
        ELSE
          3
      END, mark_logs.updated_at
    "
  end

  def self.unknown_firstly_query
    "
      CASE
        WHEN mark_logs.id is NULL
          THEN 0
        WHEN mark_logs.action = 1
          THEN 1
        WHEN mark_logs.action = 0
          THEN 2
        ELSE
          3
      END, mark_logs.updated_at
    "
  end
end
