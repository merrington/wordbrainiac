defmodule Wordbrainiac do
  alias Wordbrainiac.{Board, Word, Dictionary}

  def process(letters, word_lengths, dictionary_file \\ "dicts/US.txt") do
    dictionary = Dictionary.get_dict_trie(dictionary_file)
    Board.setup(letters)
    |> find_next_word(word_lengths, dictionary, [])
  end

  def find_next_word(_board, word_lengths, _dictionary, words) when length(word_lengths) == 0 do
    words
  end

  def find_next_word(board, word_lengths, dictionary, solutions) do
    board
    |> Word.find(hd(word_lengths))
    |> Dictionary.check_words(dictionary)
    #|> Enum.reduce(solutions, fn (solution = %{:path => path, :word => _word}, solutions) ->
    |> Enum.map(fn (solution = %{:path => path, :word => word}) ->
      List.flatten(
        Board.remove_path(board, path)
        |> find_next_word(tl(word_lengths), dictionary, solutions ++ [solution])
      )
    end)
  end
end
