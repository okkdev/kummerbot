defmodule KummerbotTest do
  use ExUnit.Case
  doctest Kummerbot

  test "greets the world" do
    assert Kummerbot.hello() == :world
  end
end
