defmodule ExMonTest do
  use ExUnit.Case

  # Para podermos pegar as mensagens printadas na tela, já que a chamada do IO.puts() retorna :ok
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_average: :soco, move_heal: :cura, move_random: :chute},
        name: "Alba"
      }

      assert expected_response == ExMon.create_player("Alba", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game starts, returns a message" do
      player = Player.build("Alba", :chute, :soco, :cura)

      # Tudo que se deseja capturar deve estar dentro da função anônima de capture_io
      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      # =~  ->  Procurar na mensagem, como um Regex
      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end
end
