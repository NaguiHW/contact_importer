class CreateErrorContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :error_contacts do |t|
      t.string :name
      t.text :reason, null: false, array: true, default: []

      t.timestamps
    end
  end
end
