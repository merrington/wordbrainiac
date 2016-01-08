defmodule Wordbrainiac.Word do
  def find(board, length) do
    board
    |> build_moves
    |> build_paths
    # 1. build all "length" strings
    # 2. build a regex using

    #Enum.map(Map.size(board), )
  end

  def build_moves(board) do
    Enum.reduce(board, Map.new, fn {rowNum, row}, map ->
      Enum.reduce(row, map, fn {colNum, cell}, map ->
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

  defp valid_tile(board, row, col) do
    Map.has_key?(board, row) and Map.has_key?(board[row], col)
  end

  def build_paths(moveMap) do
    #take the current "path" being built, copy it as many times as there are possible next moves (length(cell))
    Enum.reduce(moveMap, [], fn {rowNum, row}, paths ->
      Enum.reduce(row, paths, fn {colNum, cell}, paths ->
        Enum.map(paths, fn path ->

        end)
      end)
    end)
  end

#  def build_word(board, path, length) when length == 0 do
#    Enum.reverse(path)
#    |> Enum.map_join(&([board[elem(&1, 0)][elem(&1,1)]]))
#  end
#  def build_word(board, path, length) do
#    Enum.each(-1..1, fn(x) ->
#      Enum.each(-1..1, fn(y) ->
#        case {elem(hd(path), 0) + x, elem(hd(path), 1) + y} do
#           {a, b} when a >= 0 and b >= 0-> ''
#             if !Enum.member?(path, {x, y}) do
#               build_word(board, [{a, b} | path], length-1)
#             end
#           _ -> ''
#        end
#      end )
#    end )
#  end


end
