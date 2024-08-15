defmodule GildedRose.Item.Generic do
  @moduledoc """
  From the `README`:

  - At the end of each day our system lowers both values for every item

  Pretty simple, right? Well this is where it gets interesting:

  - Once the _sell_in_ days is less then zero, _quality_ degrades twice as fast
  - The _quality_ of an item is never negative
  """

  @behaviour GildedRose.Inventory

  alias GildedRose.Item
  alias GildedRose.Quality

  @impl true
  def increment_age_by_1_day(%Item{sell_in: sell_in} = item) when sell_in <= 0 do
    %{item | sell_in: item.sell_in - 1, quality: Quality.decrease_by_two(item.quality)}
  end

  def increment_age_by_1_day(%Item{} = item) do
    %{item | sell_in: item.sell_in - 1, quality: Quality.decrease_by_one(item.quality)}
  end
end
