defmodule Wordbrainiac.Word do
  def find(board, length) do
    board
    |> build_moves
    |> build_paths(length)
    |> build_words(board)
    # 1. build all "length" strings
    # 2. build a regex using
  end

  def build_moves(board) do
    Enum.reduce(board, Map.new, fn {rowNum, row}, map ->
      Enum.reduce(row, map, fn {colNum, _cell}, map ->
        case Map.has_key?(map, rowNum) do
          true ->
            Map.put(map, rowNum, Map.put(map[rowNum], colNum, find_neighbors(board, rowNum, colNum)))
          false ->
            Map.put(map, rowNum, Map.put(Map.new, colNum, find_neighbors(board, rowNum, colNum)))
        end
      end)
    end)
  end

  def find_neighbors(board, rowNum, colNum) do
    Enum.reduce(-1..1, [], fn(x, neighbours) ->
      Enum.reduce(-1..1, neighbours, fn(y, neighbours) ->
        case valid_tile(board, rowNum+x, colNum+y) and (x != 0 or y != 0) do
          true -> [{rowNum+x, colNum+y} | neighbours]
          _ -> neighbours
        end
      end)
    end)
  end

  defp valid_tile(board, row, col), do: Map.has_key?(board, row) and Map.has_key?(board[row], col)

  def build_paths(moveMap, length) do
    Enum.reduce(moveMap, [], fn {rowNum, row}, paths ->
      Enum.reduce(row, paths, fn {colNum, _cell}, paths ->
        [add_letter(moveMap, [{rowNum, colNum}], rowNum, colNum, length-1) | paths]
      end)
    end)
    |> flatten_paths
  end

  defp add_letter(_moveMap, path, _rowNum, _colNum, length) when length == 0, do: path

  defp add_letter(moveMap, path, rowNum, colNum, length) do
    Enum.filter_map(moveMap[rowNum][colNum], &(!Enum.member?(path, &1)), fn nextCell = {nextCellRow, nextCellCol} ->
      add_letter(moveMap, [nextCell | path], nextCellRow, nextCellCol, (length-1))
    end)
  end

  def flatten_paths(paths), do: do_flatten(paths, [])
  def do_flatten([ head | tail ], tail2) when is_list(head) and is_list(hd(head)) do
    do_flatten(head, do_flatten(tail, tail2))
  end
  def do_flatten([ head | tail ], tail2) do
     [ head | do_flatten(tail, tail2) ]
  end
  def do_flatten([], tail) do
    tail
  end

  def build_words(paths, board) do
    Enum.map(paths, fn(path) ->
      Enum.reverse(path)
      |> Enum.map_join(&([board[elem(&1, 0)][elem(&1,1)]]))
    end)
  end

end
