class AddIsBoxedToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :is_boxed, :boolean, null: false, default: false
  end
end
