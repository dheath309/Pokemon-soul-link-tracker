class DeleteOnCascade < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :teams, :games
    add_foreign_key :teams, :games, on_delete: :cascade

    remove_foreign_key :pokemons, :teams
    add_foreign_key :pokemons, :teams, on_delete: :cascade

    remove_foreign_key :links, :pokemons, column: "pokemon1_id"
    add_foreign_key :links, :pokemons, column: "pokemon1_id", on_delete: :cascade

    remove_foreign_key :links, :pokemons, column: "pokemon2_id"
    add_foreign_key :links, :pokemons, column: "pokemon2_id", on_delete: :cascade
  end
end
