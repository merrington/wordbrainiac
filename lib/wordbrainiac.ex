defmodule Wordbrainiac do
  alias Wordbrainiac.{Board, Word, Dictionary}

  def process(board_size, letters, word_lengths, dictionary_file \\ "wordlist.txt") do
    Board.setup(board_size, letters)
    |> Word.find(hd(word_lengths))
    |> Dictionary.find_real_words(dictionary_file)
  end
end
