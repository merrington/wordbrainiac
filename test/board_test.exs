defmodule BoardTest do
  use ExUnit.Case
  doctest Wordbrainiac.Board

  test "board setup" do
     assert Wordbrainiac.Board.setup('abcdefghi') == %{
       0 => %{ 0 => ?a, 1 => ?b, 2 => ?c},
       1 => %{ 0 => ?d, 1 => ?e, 2 => ?f},
       2 => %{ 0 => ?g, 1 => ?h, 2 => ?i},
     }
  end

  test "deleting a path" do
    board = Wordbrainiac.Board.setup('abcdefghijklmnop')
    # a b c d
    # e f g h
    # i j k l
    # m n o p
    path = [{3, 3}, {2, 3}, {3, 2}, {2, 2}, {1, 3}, {0, 3}]
    # a b
    # e f
    # i j c
    # m n g

    new_board = Wordbrainiac.Board.remove_path(board, path)
    IO.inspect(board)
    IO.inspect(new_board)
    assert get_in(new_board, [1, 1]) == ?f
    assert get_in(new_board, [1, 2]) == nil
    assert get_in(new_board, [2, 1]) == ?j
    assert get_in(new_board, [2, 2]) == ?c
    assert get_in(new_board, [3, 2]) == ?g
    assert Map.has_key?(new_board[1], [0]) == false
    assert Map.has_key?(new_board[2], [0]) == false
    assert Map.has_key?(new_board[2], [1]) == false
  end
end
