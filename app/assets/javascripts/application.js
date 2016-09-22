// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

var greens_hidden = false;
function toggle_greens() {
  greens_hidden = !greens_hidden;
  if(greens_hidden){
    $(".q2").parent().parent().hide();
    $("#tgreen").css("text-decoration", "line-through");
  }
  else {
    $(".q2").parent().parent().show();
    $("#tgreen").css("text-decoration", "none");
  }
}

var blues_hidden = false;
function toggle_blues() {
  blues_hidden = !blues_hidden;
  if(blues_hidden){
    $(".q3").parent().parent().hide();
    $("#tblue").css("text-decoration", "line-through");
  }
  else {
    $(".q3").parent().parent().show();
    $("#tblue").css("text-decoration", "none");
  }
}
