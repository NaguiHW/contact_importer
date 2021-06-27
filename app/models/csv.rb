class Csv < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  def self.return_headers(file)
    File.open(file.path) do |row|
      return CSV.parse_line(row)
    end
  end

  def self.import(path, name, date_of_birth, phone, address, credit_card, franchise, email)
    CSV.foreach(path, headers: true) do |row|
      row_hash = row.to_hash
      puts row_hash[name]
      puts row_hash[date_of_birth]
      puts row_hash[phone]
      puts row_hash[address]
      puts row_hash[credit_card]
      puts row_hash[franchise]
      puts row_hash[email]
      # User.create! row.to_hash
    end
  end
end
