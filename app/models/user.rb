class User < ApplicationRecord
  validates :email, uniqueness: true
  has_secure_password

  after_create :create_default_glossary

  has_many :collects
  has_many :glossaries, through: :collects

  has_many :mark_logs

  def login
    JWT.encode({
      user_id: id,
      created_at: DateTime.now.strftime("%Q"),
    }, Rails.application.credentials.secret_key_base)
  end

  private

  def create_default_glossary
    glossaries << Glossary.create(
      title: "#{name} 的 生词本",
      content: "用户创建时自动创建的默认生词本",
      owner_id: self.id,
    )
  end
end
