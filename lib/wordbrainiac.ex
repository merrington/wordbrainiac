defmodule Wordbrainiac do
  alias Wordbrainiac.Board
  alias Wordbrainiac.Word

  def process(board_size, letters, word_lengths) do
    Board.setup(board_size, letters)
    |> solve(word_lengths)
  end

  def solve(board, word_lengths) do
    Enum.each(1..Map.size(word_lengths), &(Word.find(board, &1)))
  end
end
