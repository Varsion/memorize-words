class Vocabulary < ApplicationRecord
  validates :display, uniqueness: true
  has_many :sentences

  has_many :mark_logs

  enum language: { en: 0 }

  def user_state(user_id)
    mark_logs.find_by(user_id: user_id)&.action || "unknown"
  end
end
