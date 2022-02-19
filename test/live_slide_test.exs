defmodule LiveSlideTest do
  use ExUnit.Case
  doctest LiveSlide

  test "greets the world" do
    assert LiveSlide.hello() == :world
  end
end
