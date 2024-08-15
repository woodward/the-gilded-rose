defmodule GildedRose.Item.Conjured do
  @moduledoc """
  From the `README`:

  We have recently signed a supplier of conjured items. This requires an update to our system:

  - "Conjured" items degrade in _quality_ twice as fast as normal items
  """

  @behaviour GildedRose.Inventory

  @impl true
  def increment_age_by_1_day(item) do
    item
  end
end
