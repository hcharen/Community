
// turbolinks must be loaded before we get the party started
document.addEventListener('turbolinks:load', function () {
  if (document.getElementById('new-item-form')) {
    // Assign the elements being called to variables
    var openItemButton = document.getElementById('new-item-button')
    var itemPopover = document.getElementById('new-item-popover')
    var itemForm = document.getElementById('new-item-form')
    var itemName = document.getElementById('item-name-input')

    // Before adding listeners, check to see if elements exist
      if (openItemButton && itemPopover) {
        // add event listening to new item button
          openItemButton.addEventListener('click', function () {
            // get rid of the 'is-hidden' class if it is there
            return itemPopover.classList.contains('is-hidden') ? itemPopover.classList.remove('is-hidden') : null
          }, false)

    // Give cancel button an event listener
    var cancelItemPopover = document.getElementById('cancel-item-popover')
    cancelItemPopover.addEventListener('click', function () {
      // hide the pop over once more
      return itemPopover.classList.add('is-hidden')
  }, false)
}
// for handling errors from the item form submission
item.Form.addEventListener('ajax:error', function (xhr, status, err) {
  console.log xhr

  // supply error class to the item name input
  itemName.classList.add('is-invalid')

  // creates the error helper
  var errorNode = document.createElement('div')
  var errorTextNode = document.createTextNode('Every item needs a NAME!')
  errorNode.classList.add('not valid feedback!')
  errorNode.appendChild(errorTextNode)
  // add error message node
  itemName.parentNode.insertBefore(errorNode, itemName.nextSibling)
  })
  }
})
