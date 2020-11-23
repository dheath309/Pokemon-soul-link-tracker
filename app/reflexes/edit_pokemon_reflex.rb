# frozen_string_literal: true

class EditPokemonReflex < ApplicationReflex
  include CableReady::Broadcaster

  def edit(name, room_id)
    pokemon_id = element.dataset[:id].to_i
    # TODO some auth or something for this
    @pokemon = Pokemon.find(pokemon_id)
    @pokemon.update(nickname: name)
    channel_name = "game-#{room_id}"
    cable_ready[channel_name].set_value(
      selector: "#pokemon-#{pokemon_id}",
      value: "#{name}"
    )
    cable_ready.broadcast
  end

  def edit_pokedex_id(new_pokedex_id, room_id)
    pokemon_id = element.dataset[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    # Check if pokemon is in the user's game
    @game = Game.find_by(room_id: room_id)
    @all_pokemon = Rails.cache.read("all_pokemon")
    if @game.teams.find(@pokemon.team_id)
      # TODO Store pokemon's pokedex name as well or something
      @pokemon.update(pokedex_id: new_pokedex_id)
      channel_name = "game-#{room_id}"
      cable_ready[channel_name].morph(
        selector: "#pokemon-#{pokemon_id}-container",
        html: GamesController.render(partial: "pokemon", locals: {pokemon: @pokemon})
      )
      cable_ready.broadcast
    else
      # TODO return an error or something
    end


  end

  def display_pokedex_id_edit(room_id) 
    pokemon_id = element.dataset[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    @game = Game.find_by(room_id: room_id)
    if @game.teams.find(@pokemon.team_id)
      @is_editing_pokemon = true
      @pokemon_in_edit = pokemon_id
    end

  end

  def toggle_alive(room_id)
    pokemon_id = element.dataset[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    @game = Game.find_by(room_id: room_id)
    channel_name = "game-#{room_id}"
    if @game.teams.find(@pokemon.team_id)
      new_alive_state = !@pokemon.is_alive?
      @pokemon.is_alive = new_alive_state
      @pokemon.save

      @pokemon.linked_pokemon.each do |linked_pokemon|
        linked_pokemon.is_alive = new_alive_state
        linked_pokemon.save
      end

      cable_ready[channel_name].morph(
        selector: ".teams-container",
        html: GamesController.render(partial: "teams", locals: {teams: @game.teams})
      )
    end
  end

  def toggle_boxed(room_id)
    pokemon_id = element.dataset[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    @game = Game.find_by(room_id: room_id)
    channel_name = "game-#{room_id}"
    if @game.teams.find(@pokemon.team_id)
      new_boxed_state = !@pokemon.is_boxed?
      @pokemon.is_boxed = new_boxed_state
      @pokemon.save

      @pokemon.linked_pokemon.each do |linked_pokemon|
        linked_pokemon.is_boxed = new_boxed_state
        linked_pokemon.save
      end

      cable_ready[channel_name].morph(
        selector: ".teams-container",
        html: GamesController.render(partial: "teams", locals: {teams: @game.teams})
      )
    end
  end

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

end
