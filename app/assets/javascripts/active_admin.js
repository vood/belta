//= require active_admin/base
//= require tinymce-jquery

$(document).ready(function() {
  $('.editor').tinymce({
      theme: 'advanced'
  })
  $('<li id="crawler"><a href="/crawler/index">Запустить паука</a></li>').appendTo('#tabs');
});
