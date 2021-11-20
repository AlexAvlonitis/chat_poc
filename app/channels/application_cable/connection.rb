module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = User.find_by(id: cookie_user_id)
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def cookie_user_id
      cookies.encrypted['_chat_poc_session']['warden.user.user.key']&.first
    end
  end
end
