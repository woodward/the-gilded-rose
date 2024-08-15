defmodule GildedRose.Item.Generic do
  @moduledoc false

  @behaviour GildedRose.Inventory

  alias GildedRose.Quality

  @impl true
  def increment_age_by_1_day(item) do
    %{item | sell_in: item.sell_in - 1, quality: Quality.decrease_by_one(item.quality)}
  end
end
