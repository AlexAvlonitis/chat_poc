require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { instance_double(User)}

  it "successfully connects" do
    allow(User).to receive(:find_by).and_return(user)

    connect '/cable'
    expect(connection.current_user).to eq user
  end

  it "rejects connection" do
    expect { connect "/cable" }.to have_rejected_connection
  end
end
