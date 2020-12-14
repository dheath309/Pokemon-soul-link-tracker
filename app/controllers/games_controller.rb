class GamesController < ApplicationController
  require "poke-api-v2"

  def index
    @game = Game.new
    room_id = @game.create_slug
    redirect_to "/#{room_id}"
  end

  def show
    @game_id = params[:gameId]
    if @game_id.length < 7
      # TODO game id too short, error page
      render file: "#{Rails.root}/public/game_id_too_short.html", status: 404
    end
    @game = Game.find_or_create_by(room_id: @game_id)
    # TODO Handle when a game is not created (too short room id for example)
    
    @all_pokemon = Rails.cache.read("all_pokemon")
    if @all_pokemon.nil?
      @all_pokemon = PokeApi.get(pokedex: "national").pokemon_entries
      Rails.cache.write("all_pokemon", @all_pokemon)
    end
  end
end
