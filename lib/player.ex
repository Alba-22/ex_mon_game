defmodule ExMon.Player do
  # Variáveis de módulo
  @required_keys [:life, :name, :move_random, :move_average, :move_heal]
  @max_life 100

  # Fazer com que os campos da struct sejam obrigatórios
  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name, move_random, move_average, move_heal) do
    %ExMon.Player{
      life: @max_life,
      name: name,
      move_random: move_random,
      move_average: move_average,
      move_heal: move_heal
    }
  end
end
