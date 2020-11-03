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
    if @game.teams.find(@pokemon.team_id)
      @pokemon.update(pokedex_id: new_pokedex_id)
      channel_name = "game-#{room_id}"
      cable_ready[channel_name].set_value(
        selector: "#pokemon-id-#{pokemon_id}",
        value: "#{new_pokedex_id}"
      )
      cable_ready.broadcast
    else
      # TODO return an error or something
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
