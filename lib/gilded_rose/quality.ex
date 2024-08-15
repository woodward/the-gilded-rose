defmodule GildedRose.Quality do
  @moduledoc false

  @type t :: non_neg_integer()

  @max 50
  @min 0

  @spec increase_by_one(t()) :: t()
  def increase_by_one(quality) when quality >= @max - 1, do: @max
  def increase_by_one(quality), do: quality + 1

  @spec increase_by_two(t()) :: t()
  def increase_by_two(quality) when quality >= @max - 2, do: @max
  def increase_by_two(quality), do: quality + 2

  @spec decrease_by_one(t()) :: t()
  def decrease_by_one(quality) when quality <= @min + 1, do: @min
  def decrease_by_one(quality), do: quality - 1

  @spec decrease_by_two(t()) :: t()
  def decrease_by_two(quality) when quality <= @min + 2, do: @min
  def decrease_by_two(quality), do: quality - 2
end
