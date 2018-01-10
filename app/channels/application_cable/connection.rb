module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # This is called AFTER conection
    # It assigns the 'current_user' variable an instance of a logged user
    def connect
      self.current_user = find_verified_user
    end

    protected

    # Devise uses Warden, which assigns env['warden'] ALL INFORMATION about the session and authentication
    # about a specific user
    # Connection with the server will not be authorized unless the user is LOGGED-IN!
    def find_verified_user
      if (current_user = env['warden'].user)
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
