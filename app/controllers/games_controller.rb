class GamesController < ApplicationController

  def index
    @game = Game.order("created_at DESC").first
    #@game = Game.create
    #@game.save
  end
end
