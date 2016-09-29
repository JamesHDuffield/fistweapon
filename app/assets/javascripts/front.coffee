# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(() ->
  data = $('#guild-tabard').data()
  if data
    tabard = new GuildTabard('guild-tabard', {
      'ring': 'horde',
      'bg': [ 0, data.bg ],
      'border': [ data.border, data.borderColour ],
      'emblem': [ data.icon, data.iconColour ]
    })

  toggle_item_filter = (event) ->
    filter = $(event.target)
    isHiddenNow = !filter.data('hidden')
    filter.data('hidden', isHiddenNow)
    rows = $(filter.data('hide-class')).closest('tr')
    if isHiddenNow
      rows.hide()
      filter.addClass 'striked'
    else
      rows.show()
      filter.removeClass 'striked'
    return false

  $('#tgreen').click toggle_item_filter
  $('#tblue').click toggle_item_filter
)
