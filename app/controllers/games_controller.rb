class GamesController < ApplicationController

  def index
    @game = Game.order("created_at DESC").first
  end
end
