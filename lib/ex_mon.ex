defmodule ExMon do
  alias ExMon.Player
  # alias ExMon.Player, as: player

  def create_player(name, move_random, move_average, move_heal) do
    Player.build(name, move_random, move_average, move_heal)
  end
end
