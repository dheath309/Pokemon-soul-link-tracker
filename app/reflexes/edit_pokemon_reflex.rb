# frozen_string_literal: true

class EditPokemonReflex < ApplicationReflex
  include CableReady::Broadcaster

  def edit(name, roomId)
    pokemon_id = element.dataset[:id].to_i
    # TODO some auth or something for this
    @pokemon = Pokemon.find(pokemon_id)
    @pokemon.update(nickname: name)
    channel_name = "game-#{roomId}"
    # TODO If we have some way of getting the channel name like above, we can use it in cable_ready to broadcast to that roomid
    # Remember that the room ids should be random enough that it doesn't matter if someone guesses - could just pull the room id from the 
    # url on each reflex action and send it along
    cable_ready[channel_name].set_value(
      selector: "#pokemon-#{pokemon_id}",
      value: "#{name}"
    )
    cable_ready.broadcast
  end

  def edit_pokedex_id(id)
    pokemon_id = element.dataset[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    # Check if pokemon is in the user's game
    if @game.teams.find(@pokemon.team_id)
      # TODO Save or not
      puts "IS IN THE GAME"
    else
      puts "NOT IN THE GAME"
    end

    @pokemon.update(pokedex_id: id)
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
