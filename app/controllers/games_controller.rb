class GamesController < ApplicationController

  def show
    @game_id = params[:gameId]
    @game = Game.find_or_create_by(room_id: @game_id)
    # TODO Handle when a game is not created (too short room id for example)
    # TODO StimulusReflex updating ALL pages when we just want to update channel that has same room id
  end
end
