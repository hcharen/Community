class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # main method of the class
  # all code within this method will be executed when perform_later method is called
  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)

    # these guys connect with a specific channel and send a conversation_id and HTML code using a partial!
    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end

  private

  # in rails 5, you can render HTML code from any partial or view by calling the ApplicationController.render
  # method OUTSIDE of a controller! - HOW COOL AND EXCITING!!
  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      window: render_window(message.conversation, user),
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end
  
end
