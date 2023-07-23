class Vocabulary < ApplicationRecord
  validates :email, uniqueness: true
  has_many :sentences
end
