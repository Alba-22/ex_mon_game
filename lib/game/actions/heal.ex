defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_heal_quantity 18..25

  def heal_life(player_atom) do
    player_atom
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life()
    |> set_life(player_atom)
  end

  defp calculate_total_life(life), do: Enum.random(@move_heal_quantity) + life

  defp set_life(life, player) when life > 100, do: update_player_life(player, 100)
  defp set_life(life, player), do: update_player_life(player, life)

  defp update_player_life(player_atom, life) do
    player_atom
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(player_atom, life)
  end

  defp update_game(player_data, player_atom, life) do
    Game.info()
    |> Map.put(player_atom, player_data)
    |> Game.update()

    Status.print_move_message(player_atom, :heal, life)
  end
end
