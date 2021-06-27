class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.references :contact, null: false, foreign_key: true
      t.text :number_ciphertext

      t.timestamps
    end
  end
end
