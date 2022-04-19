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

  describe "make_move/1" do
    setup do
      player = Player.build("Alba", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and then the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chuta)
        end)

      assert messages =~ "Invalid Move: chuta"
    end
  end
end
