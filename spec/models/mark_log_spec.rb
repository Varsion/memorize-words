require "rails_helper"

RSpec.describe MarkLog, type: :model do
  before(:each) do
    @user = create(:user)
  end

  context "relation with user and vocabulary" do
    it "work, known vocabulary" do
      voc = create(:vocabulary)
      mark_log = create(:mark_log, user: @user, vocabulary: voc)

      expect(voc.user_state(@user.id)).to eq("known")
    end

    it "work, unknown vocabulary" do
      voc = create(:vocabulary)
      mark_log = create(:mark_log, user: @user, vocabulary: voc, action: "unknown")

      expect(voc.user_state(@user.id)).to eq("unknown")
    end

    it "work, no mark log" do
      voc = create(:vocabulary)

      expect(voc.user_state(@user.id)).to eq("unknown")
    end
  end
end
