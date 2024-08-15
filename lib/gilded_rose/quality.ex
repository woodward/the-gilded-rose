defmodule GildedRose.Quality do
  @moduledoc """
  Functions for modifying the quality, which are used by the various `Item` modules to enforce the
  quality rules

  From the `README`:
  - The _quality_ of an item is never negative
  - The _quality_ of an item is never more than 50
  """

  @type t :: non_neg_integer()

  @max 50
  @min 0

  @spec increase_by_one(t()) :: t()
  def increase_by_one(quality) when quality >= @max - 1, do: @max
  def increase_by_one(quality), do: quality + 1

  @spec increase_by_two(t()) :: t()
  def increase_by_two(quality) when quality >= @max - 2, do: @max
  def increase_by_two(quality), do: quality + 2

  @spec increase_by_three(t()) :: t()
  def increase_by_three(quality) when quality >= @max - 3, do: @max
  def increase_by_three(quality), do: quality + 3

  # ----------------------

  @spec decrease_by_one(t()) :: t()
  def decrease_by_one(quality) when quality <= @min + 1, do: @min
  def decrease_by_one(quality), do: quality - 1

  @spec decrease_by_two(t()) :: t()
  def decrease_by_two(quality) when quality <= @min + 2, do: @min
  def decrease_by_two(quality), do: quality - 2
end
