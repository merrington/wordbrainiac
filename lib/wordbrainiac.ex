defmodule Wordbrainiac do
  def process(board_size, letters, word_lengths) do
    Wordbrainiac.Board.setup(board_size, letters)
  end
end
