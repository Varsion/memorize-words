require "rails_helper"

RSpec.describe User, type: :model do
  it "user created with default glossary" do
    user = User.create(
      name: "jianhua",
      email: "jianhua@test.com",
      password: "123456",
    )
    expect(Glossary.count).to eq(1)
    expect(Glossary.first.title).to eq("jianhua 的 生词本")
    expect(Glossary.first.owner).to eq(user)
  end
end
