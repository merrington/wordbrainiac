defmodule BoardTest do
  use ExUnit.Case
  doctest Wordbrainiac.Board

  test "board setup" do
     assert Wordbrainiac.Board.setup(3, 'abcdefghi') == %{
       0 => %{ 0 => ?a, 1 => ?b, 2 => ?c},
       1 => %{ 0 => ?d, 1 => ?e, 2 => ?f},
       2 => %{ 0 => ?g, 1 => ?h, 2 => ?i},
     }
  end

  test "deleting a path" do
    board = Wordbrainiac.Board.setup(2, 'late')
    path = [{1,1}]

    new_board = Wordbrainiac.Board.remove_path(board, path)
    assert Map.has_key?(new_board[1], [0]) == false
  end
end
