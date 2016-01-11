defmodule DictionaryTest do
  use ExUnit.Case

  test "finding valid words" do
    board = Wordbrainiac.Board.setup(2, 'late')
    words = Wordbrainiac.Word.find(board, 4)

    Enum.map(Wordbrainiac.Dictionary.find_real_words(words, "10k_words.txt"), &(IO.puts &1))
  end
end
