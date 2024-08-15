defmodule GildedRose.ItemType do
  @moduledoc """
  Types of Items
  """

  @type t :: :generic | :aged_brie | :sulfuras | :backstage_passes | :conjured

  @spec new(String.t()) :: t()
  def new(item_name) do
    item_name = item_name |> String.downcase()

    cond do
      item_name |> String.starts_with?("conjured") -> :conjured
      item_name |> String.starts_with?("aged brie") -> :aged_brie
      item_name |> String.starts_with?("sulfuras") -> :sulfuras
      item_name |> String.starts_with?("backstage passes") -> :backstage_passes
      true -> :generic
    end
  end
end
