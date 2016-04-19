$(document).ready ->

  $ ->
    $chats = $('#chat_list p').map(->
      $(this).text()
    ).get()
    $('#message_search').autocomplete source: $chats

  #  $ ->
#    $('#message_search').typeahead
#      name: "message"
#      remote: "/messages/autocomplete?query=%QUERY"

  $('.new_chat').click ->
    if $('#name').val().length > 0
      data = name: $('#name').val()
      chat = $.post('/chats', data, 'json')
      chat.done (data) ->
        $("#name").val('')
        $("#chat_list").append($("<p> <a href=/chats/#{data.id}/messages>#{data.name}</a> </p>"));
        return
    else
      alert('Name not be blank?')

  $('.refresh_chats').click ->
    chat = $.get('/refresh_chats')
    chat.done (data) ->
      $("#chat_list").replaceWith(data);
      return

  $('.refresh_users').click ->
    chat = $.get('/refresh_users', id: $(".refresh_users").val())
    chat.done (data) ->
      $(".users_chat").replaceWith(data);
      return

  $('.exit_chat').click ->
    chat = $.get('/exit_chat', id: $(".refresh_users").val(), 'json')
    window.location.replace('/chats')