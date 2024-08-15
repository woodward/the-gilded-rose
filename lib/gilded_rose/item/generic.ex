defmodule GildedRose.Item.Generic do
  @moduledoc false

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
