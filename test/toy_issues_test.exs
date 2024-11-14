defmodule ToyIssuesTest do
  use ExUnit.Case
  doctest ToyIssues

  test "greets the world" do
    assert ToyIssues.hello() == :world
  end
end
