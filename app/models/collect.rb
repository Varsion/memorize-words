class Collect < ApplicationRecord
  belongs_to :user
  belongs_to :glossary
end
