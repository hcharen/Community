class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  # executes a code or a method passed in params when a record has been CREATED and SUCCESSFULLY INSERTED in # to a database - when SQL commit is done
  # This currently causes messages not to render due to an error being thrown in the messages controller,
  # uninitialized constant MessageBroadCastJob
  # commenting this method out make's messages show up
  after_create_commit { MessageBroadcastJob.perform_later(self) }

end
