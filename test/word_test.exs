defmodule WordTest do
  use ExUnit.Case

#  test "find a list of words" do
#    board = %{
#      0 => %{ 0 => ?l, 1 => ?a },
#      1 => %{ 0 => ?t, 1 => ?e }
#    }
#
#    assert Enum.member?(Wordbrainiac.Word.find(board, 4), "late")
#  end
#
#  test "building a complete word" do
#    board = %{
#      0 => %{ 0 => ?l, 1 => ?a },
#      1 => %{ 0 => ?t, 1 => ?e }
#    }
#
#    path = [{1,1}, {1, 0}, {0, 1}, {0,0}]
#    #path = [[1, 1], [1, 0], [0, 1], [0, 0]]
#
#    assert Wordbrainiac.Word.build_word(board, path, 0) == "late"
#  end

  test "find neighbours" do
    board = Wordbrainiac.Board.setup(2, 'late')
    neighbours = Wordbrainiac.Word.find_neighbors(board, 0, 0)

    assert length(neighbours) == 3
  end

  test "find neighbours in non-square board" do
    board2 = %{
      0 => %{ 0 => ?l },
      1 => %{ 0 => ?t, 1 => ?e }
    }

    neighbours2 = Wordbrainiac.Word.find_neighbors(board2 , 0, 0)
    assert neighbours = [{1,1}, {1,0}]
  end

  test "build the moves map" do
    board = Wordbrainiac.Board.setup(2, 'late')
    moves = Wordbrainiac.Word.build_moves(board)

    assert Map.size(moves) == 2
    assert Map.size(moves[0]) == 2
    assert length(moves[0][0]) == 3
  end

#  test "finding a path of letters" do
#    board = %{
#      0 => %{ 0 => ?l, 1 => ?a },
#      1 => %{ 0 => ?t, 1 => ?e }
#    }
#
#
#    path = [{0, 0}]
#    #path = [[0, 0]]
#
#    assert length Wordbrainiac.Word.build_word(board, path, 4) == 6
#  end
end
