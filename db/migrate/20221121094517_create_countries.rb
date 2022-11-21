class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :currency, null: false
      t.json :fields, null: false
      t.timestamps
    end
  end
end
