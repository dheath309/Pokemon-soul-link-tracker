# frozen_string_literal: true

class EditTeamReflex < ApplicationReflex
  include CableReady::Broadcaster
  def edit_name(name, room_id)
    team_id = element.dataset[:id].to_i
    @game = Game.find_by(room_id: room_id)
    @team = @game.teams.find(team_id)
    return if @team.nil?

    @team.update(name: name)
    channel_name = "game-#{room_id}"
    cable_ready[channel_name].set_value(
      selector: "#team-#{team_id}-name",
      value: "#{name}"
    )
    cable_ready.broadcast
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
