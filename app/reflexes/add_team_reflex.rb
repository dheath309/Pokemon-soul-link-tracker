# frozen_string_literal: true

class AddTeamReflex < ApplicationReflex
  include CableReady::Broadcaster
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

  def add(room_id)
    @game = Game.find_by(room_id: room_id)
    @team = @game.teams.create
    # TODO Need to keep track of amount of pokemon added so that when adding a new team, it is the same amount as the others. Should probably keep track of in Game
    pokemon_count = @game.teams.first.pokemons.count
    
    channel_name = "game-#{room_id}"
    pokemon_count.times do
      if @team.pokemons.count < 6
        @pokemon = @team.pokemons.create
        @pokemon.nickname = "Bulbasaur"
        @pokemon.pokedex_id = 1
        @pokemon.save
      end
    end
    cable_ready[channel_name].insert_adjacent_html(
      # TODO This likely needs a specific id (use team id on the selector?)
      selector: ".teams-container",
      html: GamesController.render(partial: "team", locals: {team: @team})
    )
    cable_ready.broadcast

  end

end
