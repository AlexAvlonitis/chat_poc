require "rails_helper"

RSpec.describe MessagesController, type: :controller do
  let!(:room) { create(:room, name: Room::MAIN_ROOM_NAME) }
  let(:params) do
    { params: { message: { content: 'Test message' } } }
  end

  describe "POST create" do
    context 'when user is authenticated' do
      login_user

      it "returns a 201" do
        post :create, params
        expect(response).to have_http_status(:created)
      end

      it 'calls the message broadcast job' do
        expect(MessageBroadcastJob)
          .to receive(:perform_later)
          .with(room, Message, @user)

        post :create, params
      end

      context 'when there is a problem saving the message' do
        let(:room) { create(:room, name: '') }

        it 'redirects to rooms index page and shows the error' do
          post :create, params
          expect(response).to redirect_to(:rooms)
          expect(flash[:alert]).to eq ['Room must exist']
        end
      end
    end

    context 'when user is not authenticated' do
      it "redirects to sign in page" do
        post :create, params
        expect(response).to redirect_to(:new_user_session)
      end
    end
  end
end
