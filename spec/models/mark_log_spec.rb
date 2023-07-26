require "rails_helper"

RSpec.describe MarkLog, type: :model do
  context "relation with user and vocabulary" do
    it "work" do
      voc_1 = create(:vocabulary)
      voc_2 = create(:vocabulary)
      voc_3 = create(:vocabulary)
      user = create(:user)

      mark_log_1 = create(:mark_log, user: user, vocabulary: voc_1)
      mark_log_2 = create(:mark_log, user: user, vocabulary: voc_2, action: "unknown")

      expect(voc_1.user_state(user.id)).to eq("known")
      expect(voc_2.user_state(user.id)).to eq("unknown")
      expect(voc_3.user_state(user.id)).to eq("unknown")
    end
  end
end
