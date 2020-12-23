class UpdateDefaultPokemonName < ActiveRecord::Migration[6.0]
  def change
    change_column_default :pokemons, :nickname, ""
  end
end
