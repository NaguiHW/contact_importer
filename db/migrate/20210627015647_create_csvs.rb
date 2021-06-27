class CreateCsvs < ActiveRecord::Migration[6.1]
  def change
    create_table :csvs do |t|
      t.references  :user, null: false, foreign_key: true
      t.text        :headers, null: false, array: true, default: []
      t.text        :name, null: false
      t.text        :status, null: false

      t.timestamps
    end
  end
end
