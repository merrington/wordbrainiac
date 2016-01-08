defmodule WordTest do
  use ExUnit.Case

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

  test "finding a path of letters" do
    board = %{
      0 => %{ 0 => ?l, 1 => ?a },
      1 => %{ 0 => ?t, 1 => ?e }
    }

    moveMap = Wordbrainiac.Word.build_moves(board)

    assert length(Wordbrainiac.Word.build_paths(moveMap, 4)) == 24
  end

  test "build a list of strings" do
    board = %{
      0 => %{ 0 => ?l, 1 => ?a },
      1 => %{ 0 => ?t, 1 => ?e }
    }

    moveMap = Wordbrainiac.Word.build_moves(board)
    paths = Wordbrainiac.Word.build_paths(moveMap, 4)

    words = Wordbrainiac.Word.build_words(paths, board)

    assert length(words) == 24
    assert Enum.member?(words, "late")
  end
end
