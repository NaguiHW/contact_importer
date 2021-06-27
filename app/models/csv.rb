class Csv < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  def self.return_headers(file)
    puts "file path #{file.path}"
    File.open(file.path) do |row|
      return CSV.parse_line(row)
    end
  end
end
