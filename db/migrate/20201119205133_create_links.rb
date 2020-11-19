class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.references :pokemon1, null: false 
      t.references :pokemon2, null: false
      t.timestamps
    end
    add_foreign_key :links, :pokemons, column: :pokemon1_id, primary_key: :id
    add_foreign_key :links, :pokemons, column: :pokemon2_id, primary_key: :id
  end
end
