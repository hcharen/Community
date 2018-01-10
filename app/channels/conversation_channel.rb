class ConversationChannel < ApplicationCable::Channel

  # adds current_user(us), or single user, whatever to a specific channel. Users within a specifc channel will # recieve code/notifications from this channel. Those users who are not apart of that(this?) specific channel # will NOT recieve it's code
  # creates a UNIQUE CHANNEL for each user
  # The sender and recipient will recieve different information, so you'll always have to notify at least two
  # channels.
  def subscribed
    stream_from "conversations-#{current_user.id}"
  end

  # removes users from a specifc channel. Once removed, they will no longer recieve code from that specific
  # channel
  # removes all connections!
  def unsubscribed
    stop_all_streams
  end
  # this creates a record and later will render a partial of a view, send an email, or log some infomation
  # this method can be named whatever you want!
  # builds a hash that based on passed data and sends data to the front-end using the
  # ActionCable.server.broadcast method to the SPECIFIC CHANNEL!
  # data sent from this method is visible in the RECIEVED method on the front-end
  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end
    Message.create(message_params)
  end

end
