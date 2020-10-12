class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :nickname, null: false
      t.integer :pokedex_id, null: false
      t.boolean :is_alive, null: false, default: false
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
