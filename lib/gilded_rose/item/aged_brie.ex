defmodule GildedRose.Item.AgedBrie do
  @moduledoc """
  From the `README`:

  - "Aged Brie" actually increases in _quality_ the older it gets

  """

  @behaviour GildedRose.Inventory

  @impl true
  def increment_age_by_1_day(item) do
    item
  end
end
