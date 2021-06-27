class CreditCard < ApplicationRecord
  belongs_to :contact
  validates :number, presence: true
  encrypts :number
end
