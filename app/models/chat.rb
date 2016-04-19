class Chat < ActiveRecord::Base
  searchkick autocomplete: ['name']
  has_many :connects
  has_many :messages
  has_many :users, through: :connects
  validates :name, presence: true

end
