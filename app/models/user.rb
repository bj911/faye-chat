class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :connects
  has_many :messages
  has_many :chats, through: :connects

end
