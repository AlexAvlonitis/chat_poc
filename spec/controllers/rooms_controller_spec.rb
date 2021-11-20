require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  let(:user2) { create(:user, email: 'asd@asd.com') }
  let(:room) { create(:room, name: Room::MAIN_ROOM_NAME) }
  let!(:message) { create(:message, room: room, user: user2) }

  describe "GET index" do
    context 'when user is authenticated' do
      login_user

      before { get :index }

      it "returns a 200" do
        expect(response).to have_http_status(:ok)
      end

      it 'sets a messages instance variable' do
        expect(assigns(:messages)).to eq [message]
      end

      it 'sets a message instance variable' do
        expect(assigns(:message)).to be_an_instance_of(Message)
      end
    end

    context 'when user is not authenticated' do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(:new_user_session)
      end
    end
  end
end
