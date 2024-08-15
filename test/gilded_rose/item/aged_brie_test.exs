defmodule GildedRose.Item.AgedBrieTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  alias GildedRose.Item
  alias GildedRose.Item.AgedBrie

  describe "does the rules for aged brie item" do
    @tag :skip
    test "the quality stays the same, and the sell in does not change" do
      item = %Item{name: "Aged Brie", sell_in: 2, quality: 0}

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)

      item = AgedBrie.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)
    end
  end
end
