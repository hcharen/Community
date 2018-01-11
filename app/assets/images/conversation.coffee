App.conversation = App.cable.subscriptions.create('ConversationChannel',

  # connected: and disconnected: perform the same actions as subscribed and unsubscribed in
  # conversation_channel.rb, just on the front-end side.

  connected: ->
  disconnected: ->

  # This function is performed when we want to render a paritial in the views
  received: (data) ->
    conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
    if data['window'] != undefined
      conversation_visible = conversation.is(':visible')
      if conversation_visible
        messages_visible = conversation.find('.panel-body').is(':visible')
        if !messages_visible
          conversation.removeClass('panel-default').addClass 'panel-success'
        conversation.find('.messages-list').find('ul').append data['message']
      else
        $('#conversations-list').append data['window']
        conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
        conversation.find('.panel-body').toggle()
    else
      conversation.find('ul').append data['message']
    messages_list = conversation.find('.messages-list')
    height = messages_list[0].scrollHeight
    messages_list.scrollTop height
    return

  # Calls the speak method from the back-end (conversation_channel.rb)
  speak: (message) ->
    @perform 'speak', message: message
)

  $(document).on 'submit', '.new_message', (e) ->
    e.preventDefault()
    values = $(this).serializeArray()
    App.conversation.speak values
    $(this).trigger 'reset'
  return


  $(document).on 'click', '.toggle-window', (e) ->
    e.preventDefault()
    panel = $(this).parent().parent()
    messages_list = panel.find('.messages-list')
    panel.find('.panel-body').toggle()
    panel.attr 'class', 'panel panel-default'
    if panel.find('.panel-body').is(':visible')
      height = messages_list[0].scrollHeight
      messages_list.scrollTop height
    return
  return

# ---
# generated by js2coffee 2.2.0

# ---
# generated by js2coffee 2.2.0