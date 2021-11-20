require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { instance_double(User) }
  let(:cookie_jar) { ActionCable::Connection::TestCookieJar }

  let(:warden_value) { [1, 'random_id'] }
  let(:session_cookie) do
    {
      '_chat_poc_session' => {
        'warden.user.user.key' => warden_value
      }
    }
  end

  before do
    allow_any_instance_of(cookie_jar).to receive(:encrypted) { session_cookie }
  end

  it "successfully connects" do
    allow(User).to receive(:find_by) { user }

    connect '/cable'
    expect(connection.current_user).to eq user
  end

  it "rejects connection" do
    allow(User).to receive(:find_by) { nil }

    expect { connect "/cable" }.to have_rejected_connection
  end
end
