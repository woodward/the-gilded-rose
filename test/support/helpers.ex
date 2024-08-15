defmodule GildedRoseTest.Helpers do
  @moduledoc false
  import ExUnit.Assertions

  def assert_item(item, opts) do
    sell_in = Keyword.get(opts, :sell_in)
    quality = Keyword.get(opts, :quality)

    assert item.sell_in == sell_in
    assert item.quality == quality
  end
end
