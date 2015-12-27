defmodule Wordbrainiac.Board do
  def setup(board_size, letters) do
    read_next(%{ 0 => %{}}, board_size, letters)
  end

  def read_next(board, _board_size, letters) when length(letters) == 0  do
    board
  end

  def read_next(board, board_size, letters) do
    row = (Map.size board) - 1
    cols = Map.size board[row]
    case col = rem(cols, board_size) do
      0 when cols == board_size ->
        read_next(Map.put(board, row+1, Map.put(%{}, col, hd(letters))), board_size, tl(letters))
      _ ->
        read_next(Map.put(board, row, Map.put(board[row], col, hd(letters))), board_size, tl(letters))
    end
  end

end
