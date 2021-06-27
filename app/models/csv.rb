class Csv < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  NAME_REGEX = /\A[a-zA-Z\-]+\z/i
  DATE_REGEX = /\A(19|20)\d{2}-?(0\d{1}|1[012])-?(0[1-9]|[12][0-9]|3[01])\z/
  PHONE_REGEX = /\A[(][+]\d{2}[)]\s{1}\d{3}(-\d{3}-\d{2}-\d{2}|\s{1}\d{3}\s{1}\d{2}\s{1}\d{2})\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def self.return_headers(file)
    File.open(file.path) do |row|
      return CSV.parse_line(row)
    end
  end

  def self.import(path, name, date_of_birth, phone, address, credit_card, email, current_user)
    CSV.foreach(path, headers: true) do |row|
      row_hash = row.to_hash
      card = row_hash[credit_card]
      card_arr = []
      if card[0] == '1' and card.length == 15
        card_arr = [card.last(4), 'UATP']
      end
      if NAME_REGEX.match(row_hash[name]) and DATE_REGEX.match(row_hash[date_of_birth]) and PHONE_REGEX.match(row_hash[phone]) and EMAIL_REGEX.match(row_hash[email]) and row_hash[address].length > 0 and card_arr.length == 2
        date = DateTime.parse(row_hash[date_of_birth]).strftime('%Y %B %e').to_s
        contact = current_user.contacts.build(name: row_hash[name],
                                      date_of_birth: date,
                                      phone: row_hash[phone],
                                      address: row_hash[address],
                                      credit_card: card_arr[0],
                                      franchise: card_arr[1],
                                      email: row_hash[email])
        contact.save
      else
        puts "AN ERROR OCCURED"
      end
    end
  end
end
