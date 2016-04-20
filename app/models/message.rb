class Message < ActiveRecord::Base
  # searchkick autocomplete: ['text']
  belongs_to :user
  belongs_to :chat
end
