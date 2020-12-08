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
    teams_count = @game.teams.count
    unless teams_count >= 6
      @team = @game.teams.create
      pokemon_count = @game.teams.first.pokemons.count
      
      channel_name = "game-#{room_id}"
      pokemon_count.times do |current_pokemon_index|
        unless @team.pokemons.count >= 100
          @pokemon = @team.pokemons.new(nickname: "Bulbasaur", pokedex_id: 1)
          @pokemon_status_already_set = false
          @game.teams.each do |team| 
            unless team == @team 
              temp_pokemon = team.pokemons[current_pokemon_index]
                unless @pokemon_status_already_set
                  @pokemon.is_alive = temp_pokemon.is_alive?
                  @pokemon.is_boxed = temp_pokemon.is_boxed?
                  @pokemon_status_already_set = true
                end
                Link.create(pokemon1: temp_pokemon, pokemon2: @pokemon)
                Link.create(pokemon1: @pokemon, pokemon2: temp_pokemon)
            end
          end
        end
      end
      cable_ready[channel_name].insert_adjacent_html(
        # TODO This likely needs a specific id (use team id on the selector?)
        selector: ".teams-container",
        html: GamesController.render(partial: "team", locals: {team: @team, i: teams_count})
      )
      cable_ready.broadcast
    end

  end

end
