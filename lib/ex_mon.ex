defmodule ExMon do
  alias ExMon.Game
  alias ExMon.Game.Status
  alias ExMon.Player
  # alias ExMon.Player, as: player

  @computer_name "Robotinik"

  def create_player(name, move_random, move_average, move_heal) do
    Player.build(name, move_random, move_average, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message()
  end
end
