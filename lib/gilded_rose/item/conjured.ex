defmodule GildedRose.Item.Conjured do
  @moduledoc """
  From the `README`:

  We have recently signed a supplier of conjured items. This requires an update to our system:

  - "Conjured" items degrade in _quality_ twice as fast as normal items
  """

  @behaviour GildedRose.Inventory

  alias GildedRose.Quality

  @impl true
  def increment_age_by_1_day(item) do
    %{item | sell_in: item.sell_in - 1, quality: quality(item.sell_in, item.quality)}
  end

  # Existing behavior:
  @spec quality(integer(), Quality.t()) :: Quality.t()
  defp quality(sell_in, quality) when sell_in >= 1, do: Quality.decrease_by_one(quality)
  defp quality(_sell_in, quality), do: Quality.decrease_by_two(quality)

  # New behavior based on the README:
  # @spec quality(integer(), Quality.t()) :: Quality.t()
  # defp quality(sell_in, quality) when sell_in >= 1, do: Quality.decrease_by_two(quality)
  # defp quality(_sell_in, quality), do: Quality.decrease_by_four(quality)
end
