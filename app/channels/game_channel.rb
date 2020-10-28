class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel_name
  end

  def channel_name
    "game-#{params[:room]}"
  end
end
