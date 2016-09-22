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

  greens_hidden = false
  blues_hidden = false

  toggle_greens = ->
    greens_hidden = !greens_hidden
    if greens_hidden
      $('.q2').parent().parent().hide()
      $('#tgreen').addClass 'striked'
    else
      $('.q2').parent().parent().show()
      $('#tgreen').removeClass 'striked'
    return false

  toggle_blues = ->
    blues_hidden = !blues_hidden
    if blues_hidden
      $('.q3').parent().parent().hide()
      $('#tblue').addClass 'striked'
    else
      $('.q3').parent().parent().show()
      $('#tblue').removeClass 'striked'
    return false

  $('#tgreen').click toggle_greens
  $('#tblue').click toggle_blues
)
