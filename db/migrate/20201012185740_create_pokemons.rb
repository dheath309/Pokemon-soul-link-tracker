class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :nickname, null: false, default: "Bulbasaur"
      t.integer :pokedex_id, null: false, default: 1
      t.boolean :is_alive, null: false, default: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
