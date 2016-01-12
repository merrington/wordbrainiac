defmodule Wordbrainiac do
  alias Wordbrainiac.{Board, Word, Dictionary}

  def process(letters, word_lengths, dictionary_file \\ "wordlist.txt") do
    dictionary = Dictionary.get_dict_trie(dictionary_file)
    Board.setup(letters)
    |> find_next_word(word_lengths, dictionary, [])
    #|> Word.find(hd(word_lengths))
    #|> Dictionary.find_real_words(dictionary_file)
  end

  def find_next_word(board, word_lengths, dictionary, words) when length(word_lengths) == 0 do
    words
  end

  def find_next_word(board, word_lengths, dictionary, solutions) do
    board
    |> Word.find(hd(word_lengths))
    |> Dictionary.find_real_words(dictionary)
    |> Enum.reduce(solutions, fn (solution = %{:path => path, :word => word}, solutions) ->
    #|> Enum.map(fn (solution = %{:path => path, :word => word}) ->
      Board.remove_path(board, path)
      |> find_next_word(tl(word_lengths), dictionary, solutions ++ [solution])
    end)
    #words
  end
end
