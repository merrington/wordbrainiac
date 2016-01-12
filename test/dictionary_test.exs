defmodule DictionaryTest do
  use ExUnit.Case

  test "finding valid words" do
    board = Wordbrainiac.Board.setup('late')
    words = Wordbrainiac.Word.find(board, 4)
    dictionary = Wordbrainiac.Dictionary.get_dict_trie("wordlist.txt")

    assert Enum.member?(Enum.map(Wordbrainiac.Dictionary.check_words(words, dictionary), &(&1[:word])), "late")
  end
end
