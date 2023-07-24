class User < ApplicationRecord
  validates :email, uniqueness: true
  has_secure_password

  has_many :collects
  has_many :glossaries, through: :collects

  def login
    JWT.encode({
      user_id: id,
      created_at: DateTime.now.strftime("%Q"),
    }, Rails.application.credentials.secret_key_base)
  end
end
