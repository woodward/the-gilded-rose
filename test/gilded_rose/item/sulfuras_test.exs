defmodule GildedRose.Item.SulfurasTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  alias GildedRose.Item
  alias GildedRose.Item.Sulfuras

  describe "does the rules for a sulfuras item" do
    test "the quality stays the same, and the sell in does not change" do
      item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80}

      item = Sulfuras.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)

      item = Sulfuras.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)

      item = Sulfuras.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)
    end
  end
end
