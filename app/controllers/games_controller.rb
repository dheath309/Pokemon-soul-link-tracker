class GamesController < ApplicationController
  require "poke-api-v2"

  def show
    @game_id = params[:gameId]
    @game = Game.find_or_create_by(room_id: @game_id)
    # TODO Handle when a game is not created (too short room id for example)

    
    @all_pokemon = Rails.cache.read("all_pokemon")
    if @all_pokemon.nil?
      @all_pokemon = PokeApi.get(pokedex: "national").pokemon_entries
      Rails.cache.write("all_pokemon", @all_pokemon)
    end
  end
end
