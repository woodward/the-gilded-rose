defmodule GildedRose.Item.BackstagePasses do
  @moduledoc """
  From the `README`:

  "Backstage passes", like aged brie, increases in _quality_ as it's _sell_in_
  value decreases; _quality_ increases by 2 when there are 10 days or less and
  by 3 when there are 5 days or less but _quality_ drops to 0 after the concert
  """

  @behaviour GildedRose.Inventory

  alias GildedRose.Quality

  @impl true
  def increment_age_by_1_day(item) do
    %{item | sell_in: item.sell_in - 1, quality: quality(item.sell_in, item.quality)}
  end

  @spec quality(integer(), Quality.t()) :: Quality.t()
  defp quality(sell_in, quality) when sell_in >= 11, do: Quality.increase_by_one(quality)
  defp quality(sell_in, quality) when sell_in >= 6, do: Quality.increase_by_two(quality)
  defp quality(sell_in, quality) when sell_in >= 1, do: Quality.increase_by_three(quality)
  defp quality(_sell_in, _quality), do: 0
end
