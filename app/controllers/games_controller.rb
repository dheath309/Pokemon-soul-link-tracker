class GamesController < ApplicationController

  def index
    @game = Game.order("created_at DESC").first
    if @game.nil?
      @game = Game.create
      @game.save
    end
  end
end
