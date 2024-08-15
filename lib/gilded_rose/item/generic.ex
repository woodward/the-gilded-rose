defmodule GildedRose.Item.Generic do
  @moduledoc false

  @behaviour GildedRose.Inventory

  @impl true
  def increment_age_by_1_day(item) do
    item
  end
end
