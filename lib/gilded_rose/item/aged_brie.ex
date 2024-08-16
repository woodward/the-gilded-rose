defmodule GildedRose.Item.AgedBrie do
  @moduledoc """
  From the `README`:

  - "Aged Brie" actually increases in _quality_ the older it gets

  """

  @behaviour GildedRose.Inventory

  alias GildedRose.Item
  alias GildedRose.Quality

  @impl true
  def increment_age_by_1_day(%Item{sell_in: sell_in} = item) when sell_in > 0 do
    %{item | sell_in: sell_in - 1, quality: Quality.increase_by_one(item.quality)}
  end

  def increment_age_by_1_day(%Item{sell_in: sell_in} = item) do
    %{item | sell_in: sell_in - 1, quality: Quality.increase_by_two(item.quality)}
  end
end
