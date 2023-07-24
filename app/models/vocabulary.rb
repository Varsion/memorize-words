class Vocabulary < ApplicationRecord
  validates :display, uniqueness: true
  has_many :sentences

  enum language: { en: 0 }
end
