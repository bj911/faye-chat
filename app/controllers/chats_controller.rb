class ChatsController < ApplicationController
  before_filter :authenticate_user!
  layout false, only: :refresh_chats

  def index
    @chats = Chat.all
  end

  def create
    @chat = Chat.create(name: params[:name]) if params[:name]
    render :json => @chat, status: :ok
  end

  def refresh_chats
    @chats = Chat.all
    render :partial => 'chats/chats'
  end

  def refresh_users
    @chat = Chat.find(params[:id])
    @users = @chat.users
    render :partial => 'messages/users'
  end

  def exit_chat
    @connect = current_user.connects.where(chat_id: params[:id]).first
    @connect.destroy
    render json: {}, status: :ok
  end

end
