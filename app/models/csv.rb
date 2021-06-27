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

  def self.import(path, name, date_of_birth, phone, address, credit_card, email, current_user, csv)
    contacts_before = current_user.contacts.count
    CSV.foreach(path, headers: true) do |row|
      row_hash = row.to_hash
      card = row_hash[credit_card]
      card_arr = []
      if card[0] == '1' and card.length == 15
        card_arr = [card.last(4), 'UATP']
      end
      date = DateTime.parse(row_hash[date_of_birth]).strftime('%Y %B %e').to_s
      contact = current_user.contacts.build(name: row_hash[name],
                                            date_of_birth: date,
                                            phone: row_hash[phone],
                                            address: row_hash[address],
                                            credit_card_four_digit: card_arr[0],
                                            franchise: card_arr[1],
                                            email: row_hash[email])
      if NAME_REGEX.match(row_hash[name]) and DATE_REGEX.match(row_hash[date_of_birth]) and PHONE_REGEX.match(row_hash[phone]) and EMAIL_REGEX.match(row_hash[email]) and row_hash[address].length > 0 and card_arr.length == 2
        if contact.save
          CreditCard.create!(contact_id: contact.id, number: card)
        else
          ErrorContact.create!(name: row_hash[name], reason: ['The datas are ok, but something went wrong. Try it again.'])
        end
      else
        contact.valid?
        ErrorContact.create!(name: row_hash[name], reason: contact.errors.full_messages)
      end
    end
    contacts_after = current_user.contacts.count
    if contacts_before == contacts_after
      csv.update(status: 'Failed')
    else
      csv.update(status: 'Finished')
    end
  end
end
