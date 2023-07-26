class MarkLog < ApplicationRecord
  belongs_to :user
  belongs_to :vocabulary

  enum action: {
    known: 0,
    unknown: 1,
  }
end
