require 'rails_helper'

Rails.application.load_tasks

describe "Weekly rake task" do
  let(:user) { create(:user) }
  let(:room) { create(:room, name: Room::MAIN_ROOM_NAME) }
  let(:mailer) { double(:mailer, deliver_now: nil) }
  let!(:message1) { create(:message, created_at: 1.week.ago.beginning_of_day - 1, room: room, user: user) }
  let!(:message2) { create(:message, created_at: 1.week.ago.beginning_of_day, room: room, user: user) }
  let!(:message3) { create(:message, room: room, user: user) }
  let!(:message4) { create(:message, created_at: 1.day.after, room: room, user: user) }

  before do
    allow(WeeklyMessagesTotalMailer).to receive_message_chain(:report, :deliver_now)
    allow(WeeklyMessagesUserMailer).to receive_message_chain(:report, :deliver_now)
  end

  it "sends weekly email reports" do
    expect(WeeklyMessagesTotalMailer)
      .to receive(:report)
      .with(user, 2)

    expect(WeeklyMessagesUserMailer)
      .to receive(:report)
      .with(user, 3)

    Rake::Task["weekly:email_report"].invoke
  end
end
