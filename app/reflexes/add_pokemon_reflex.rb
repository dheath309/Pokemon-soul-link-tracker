# frozen_string_literal: true

class AddPokemonReflex < ApplicationReflex
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
    game = Game.includes(:teams).find_by(room_id: room_id)

    # TODO Some sort of form for this really
    
    channel_name = "game-#{room_id}"
    game.teams.each do |team|
      if team.pokemons.count < 6
        @pokemon = team.pokemons.create(nickname: "Bulbasaur", pokedex_id: 1)
      end
    end
      cable_ready[channel_name].outer_html(
        selector: ".teams-container",
        html: GamesController.render(partial: "teams", locals: {teams: game.teams})
      )
      cable_ready.broadcast
  end

end
