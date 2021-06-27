class Contact < ApplicationRecord
  belongs_to :user
  NAME_REGEX = /\A[a-zA-Z\-]+\z/i
  DATE_REGEX = /\A(19|20)\d{2}\s{1}[A-Z][a-z]+\s{1}([1-9]|[12][0-9]|3[01])\z/
  PHONE_REGEX = /\A[(][+]\d{2}[)]\s{1}\d{3}(-\d{3}-\d{2}-\d{2}|\s{1}\d{3}\s{1}\d{2}\s{1}\d{2})\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, format: { with: NAME_REGEX }
  validates :date_of_birth, presence: true, format: { with: DATE_REGEX }
  validates :phone, presence: true, format: { with: PHONE_REGEX }
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :address, presence: true
  validates :credit_card_four_digit, presence: true
  validates :franchise, presence: true
  has_one :credit_card
end
