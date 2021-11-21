require "rails_helper"

RSpec.describe WeeklyMessagesUserMailer, type: :mailer do
  describe "report" do
    let(:user) { build_stubbed(:user) }
    let(:messages_user) { 10 }
    let(:mail) { described_class.report(user, messages_user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Weekly messages since your last message")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['tester@test.com'])
    end

    it "renders the body" do
      html_file = file_fixture("weekly_messages_user_fixture.html.txt").read
      txt_file = file_fixture("weekly_messages_user_fixture.txt").read

      expect(mail.html_part.body.to_s).to match(html_file)
      expect(mail.text_part.body.to_s).to match(txt_file)
    end
  end
end
