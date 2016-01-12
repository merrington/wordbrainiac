defmodule Wordbrainiac.Board do
  def setup(letters) do
    board_size = trunc(:math.sqrt(length letters))
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

  def remove_path(board, path) do
    path = Enum.sort(path, fn({row1, col1}, {row2, col2}) ->
      cond do
        col1 < col2 -> false
        col1 == col2 ->
          row1 < row2
        col1 > col2 -> true
      end
    end)

    _remove_path(board, path)
  end

  def _remove_path(board, path) when length(path) == 0 do
    board
  end

  def _remove_path(board, [{row, col} | path]) do
    Enum.reduce(row..0, board, fn(row, board) ->
      update_in(board, [row, col], fn(_) -> get_in(board, [row-1, col]) end)
    end)
    |> _remove_path(path)
  end

end
