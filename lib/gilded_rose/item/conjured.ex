defmodule GildedRose.Item.Conjured do
  @moduledoc """
  From the `README`:

  We have recently signed a supplier of conjured items. This requires an update to our system:

  - "Conjured" items degrade in _quality_ twice as fast as normal items
  """

  @behaviour GildedRose.Inventory

  alias GildedRose.Quality

  # New conjured behavior based on the README input - toggle via this config variable to true/false (in `config/config.exs`):
  @new_conjured_behavior? Application.compile_env(:gilded_rose, :new_conjured_behavior?)
  def new_conjured_behavior?, do: @new_conjured_behavior?

  @impl true
  def increment_age_by_1_day(item) do
    %{item | sell_in: item.sell_in - 1, quality: quality(item.sell_in, item.quality)}
  end

  # Note that both the new conjured behavior and the old, existing behavior are here so that the newly
  # refactored code can be run against the existing integration tests (when new_conjured_behavior? == false)
  if @new_conjured_behavior? do
    # New behavior based on the README:
    @spec quality(integer(), Quality.t()) :: Quality.t()
    defp quality(sell_in, quality) when sell_in >= 1, do: Quality.decrease_by_two(quality)
    defp quality(_sell_in, quality), do: Quality.decrease_by_four(quality)
  else
    # Existing behavior:
    @spec quality(integer(), Quality.t()) :: Quality.t()
    defp quality(sell_in, quality) when sell_in >= 1, do: Quality.decrease_by_one(quality)
    defp quality(_sell_in, quality), do: Quality.decrease_by_two(quality)
  end
end
