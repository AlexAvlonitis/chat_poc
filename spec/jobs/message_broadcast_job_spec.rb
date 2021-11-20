require "rails_helper"

describe MessageBroadcastJob, type: :job do
  let(:current_user) { {} }
  let(:room) { 'rooms' }
  let(:message) { {} }

  describe "#perform" do
    ActiveJob::Base.queue_adapter = :test

    it "enques the job" do
      expect { described_class.perform_later(room, message, current_user) }
        .to have_enqueued_job
    end

    it 'performs the job' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

      described_class.perform_later(room, message, current_user)
      expect(described_class).to have_been_performed
    end

    it 'broadcasts the message to room channel' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

      expect(RoomChannel)
        .to receive(:broadcast_to)
        .with(room, { message: message, current_user: current_user })

      described_class.perform_later(room, message, current_user)
    end
  end
end
