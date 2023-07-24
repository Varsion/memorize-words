class Glossary < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", required: false

  def can_update?(user)
    !is_system && owner == user
  end
end
