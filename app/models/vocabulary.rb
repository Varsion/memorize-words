class Vocabulary < ApplicationRecord
  validates :email, uniqueness: true
  has_many :sentences

  enum :type, en: 0
end
