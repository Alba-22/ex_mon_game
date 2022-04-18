defmodule ExMon.Game do
  use Agent

  def start(computer, player) do
    initial_value = %{
      computer: computer,
      player: player,
      turn: :player,
      status: :started
    }

    # __MODULE__ se refere ao próprio módulo
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def info do
    # & -> Função anônima
    # &1 -> Estado do jogo
    Agent.get(__MODULE__, & &1)
  end

  # Recebe um novo estado e sobreescreve o estado anterior pelo novo
  def update(state) do
    Agent.update(
      __MODULE__,
      fn _ -> state end
    )
  end

  def player, do: Map.get(info(), :player)

  def turn, do: Map.get(info(), :turn)

  def fetch_player(player), do: Map.get(info(), player)
end
