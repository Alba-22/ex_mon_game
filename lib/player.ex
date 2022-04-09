defmodule ExMon.Player do
  # Fazer com que os campos da struct sejam obrigatórios
  @enforce_keys [:life, :name, :move_random, :move_average, :move_heal]
  defstruct [:life, :name, :move_random, :move_average, :move_heal]

  def build(name, move_random, move_average, move_heal) do
    %ExMon.Player{
      life: 100,
      name: name,
      move_random: move_random,
      move_average: move_average,
      move_heal: move_heal
    }
  end
end
