# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# We have to make sure turbolinks is loaded before we work our magic
document.addEventListener 'turbolinks:load', ->
  if document.getElementById('new-item-form')
    # Assign the elements we're intrerested in to variables
    openItemButton = document.getElementById('new-item-button')
    itemPopover = document.getElementById('new-item-popover')
    itemForm = document.getElementById('new-item-form')
    itemName = document.getElementById('item-name-input')
    # Let's check to see if these elements exist before we add our listeners
    if openItemButton and itemPopover
      # Attach an event listener to our new item button
      openItemButton.addEventListener 'click', (->
        # If the item popover's class list contains the 'is-hidden' class, remove it
        # otherwise don't do anything!
        if itemPopover.classList.contains('is-hidden') then itemPopover.classList.remove('is-hidden') else null
      ), false
      # Attach an event listener to our cancel button
      cancelItemPopover = document.getElementById('cancel-item-popover')
      cancelItemPopover.addEventListener 'click', (->
        # We can safely assume that if our user can see the Cancel button, then the
        # .is-hidden class is not part of the class list of item pop-over and we can
        # remove it.
        itemPopover.classList.add 'is-hidden'
      ), false
    # Handle errors from the item form submission
    itemForm.addEventListener 'ajax:error', (xhr, status, err) ->
      # Have a good look at what's returned with a console.log()
      console.log xhr
      # Add an error class to the item name input
      itemName.classList.add 'is-invalid'
      # Create and add our error helper
      errorNode = document.createElement('div')
      errorTextNode = document.createTextNode('Name must not be blank')
      errorNode.classList.add 'invalid-feedback'
      errorNode.appendChild errorTextNode
      # Add the error message node using this ugly line of code. Thanks StackOverflow!
      itemName.parentNode.insertBefore errorNode, itemName.nextSibling
      return
  return

# ---
# generated by js2coffee 2.2.0
