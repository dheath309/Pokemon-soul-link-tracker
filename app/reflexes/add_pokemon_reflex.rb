# frozen_string_literal: true

class AddPokemonReflex < ApplicationReflex
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

  def add
    @game = Game.order("created_at DESC").first
    @team = @game.teams.first
    # If getting team id from the webpage, need to do some authentication (websocket connected to game id thing? session? (session may persist too long))
    # so that users can't just add to random teams by changing the id. (uuid id?)
    @pokemon = @team.pokemons.create
    @pokemon.nickname = "Abbb"
    @pokemon.pokedex_id = 15
    @pokemon.save

  end
end
