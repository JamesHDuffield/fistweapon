# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(() ->
  tabard = new GuildTabard('guild-tabard', {
    'ring': 'horde',
    'bg': [ 0, 5 ],
    'border': [ 5, 15 ],
    'emblem': [ 122, 15 ]
  })
)
