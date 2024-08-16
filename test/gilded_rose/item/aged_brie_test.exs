defmodule GildedRose.Item.AgedBrieTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  alias GildedRose.Item
  alias GildedRose.Item.AgedBrie

  describe "does the rules for aged brie item" do
    test "the quality stays the same, and the sell in does not change" do
      item = %Item{name: "Aged Brie", sell_in: 2, quality: 0}

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: 1, quality: 1)

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 2)

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: -1, quality: 4)
    end

    test "the quality maxes out at 50" do
      item = %Item{name: "Aged Brie", sell_in: 2, quality: 0}

      item =
        1..25
        |> Enum.reduce(item, fn _index, item ->
          AgedBrie.increment_age_by_1_day(item)
        end)

      assert_item(item, sell_in: -23, quality: 48)

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: -24, quality: 50)

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: -25, quality: 50)
    end
  end
end
