$(document).ready ->

  pathname = window.location.pathname
  $("#chat_room").scrollTop($("#chat_room")[0].scrollHeight) if pathname == "http://127.0.0.1:3000/chats/#{$('.refresh_users').val()}/messages"

  $ ->
    client = new (Faye.Client)('http://localhost:9292/faye')

    public_subscription = client.subscribe("#{pathname}", (data) ->
      tag = $('<p></p>').html("<strong>#{data.username}</strong>" + ": " + data.msg ).appendTo('#chat_room')
      $(tag).append($("<br> <span>#{data.created_at}</span>"))
      $("#chat_room").scrollTop($("#chat_room")[0].scrollHeight)
      return
    )

    $('.new_message').click ->
      data = message: $('#message').val()
      chat = $.post("#{pathname}", data, 'json')
      chat.done (data) ->
        data1 =
          username: "#{data[0]}"
          msg: $('#message').val()
          created_at: "#{data[1]}"
        client.publish("#{pathname}", data1)
        $('#message').val('')