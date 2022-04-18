defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_average_power 18..25
  @move_random_power 10..35

  def attack_opponent(opponent_atom, move) do
    damage = calculate_power(move)

    opponent_atom
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent_atom, damage)
  end

  defp calculate_power(:move_average), do: Enum.random(@move_average_power)
  defp calculate_power(:move_random), do: Enum.random(@move_random_power)

  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent_atom, damage) do
    opponent_atom
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent_atom, damage)
  end

  defp update_game(player, opponent_atom, damage) do
    Game.info()
    |> Map.put(opponent_atom, player)
    |> Game.update()

    Status.print_move_message(opponent_atom, :attack, damage)
  end
end
