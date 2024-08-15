defmodule GildedRose.Item.Sulfuras do
  @moduledoc """
  From the `README`:

  "Sulfuras" is a legendary item and as such its _quality_ is 80 and it never alters.
  """

  @behaviour GildedRose.Inventory

  @impl true
  def increment_age_by_1_day(item), do: item
end
