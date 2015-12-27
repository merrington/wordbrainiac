defmodule BoardTest do
  use ExUnit.Case
  doctest Wordbrainiac.Board

  test "board setup" do
     assert Wordbrainiac.Board.setup(3, 'abcdefghi') == %{
       0 => %{ 0 => ?a, 1 => ?b, 2 => ?c},
       1 => %{ 0 => ?d, 1 => ?e, 2 => ?f},
       2 => %{ 0 => ?g, 1 => ?h, 2 => ?i},
     }
  end
end
