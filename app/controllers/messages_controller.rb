class MessagesController < ApplicationController
  # before_filter :authenticate_user!
  before_action :get_chat, except: :search
  require 'json'

  def index
    @chats = Chat.all
    @users = @chat.users
    @messages = Message.where(chat_id: @chat.id).order("created_at desc").limit(50).reverse
    @connect = Connect.find_or_create_by(user_id: current_user.id, chat_id: @chat.id)
  end

  def search
    if params[:query].present?
      Chat.reindex
      puts @messages = Chat.search(params[:query], autocomplete: true).map(&:name)
    else
      @messages = Message.all.map(&:text)
    end
  end

  def autocomplete
    render json: Message.search(params[:query], autocomplete: true).map(&:text)
  end

  def create
    @message = current_user.messages.create(text: params[:message], chat_id: @chat.id)
    render :json => [current_user.email, @message.created_at.strftime("%H:%M %d %b. %Y")], status: :ok
  end

  def payload
    puts '+++++++++++++++++++ 888 +++++++++++++++++++++++++++'
    puts '+++++++++++++++++++ 777 +++++++++++++++++++++++++++'
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
    redirect_to root_path
  end

  private
  def get_chat
    redirect_to root_path if (@chat = Chat.where(id: params[:chat_id]).first).blank?
  end

end
