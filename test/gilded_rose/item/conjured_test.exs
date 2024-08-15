defmodule GildedRose.Item.ConjuredTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  alias GildedRose.Item
  alias GildedRose.Item.Conjured

  describe "does the rules for conjured item" do
    @tag :skip
    test "the quality stays the same, and the sell in does not change" do
      item = %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}

      item = Conjured.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)

      item = Conjured.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)

      item = Conjured.increment_age_by_1_day(item)
      assert_item(item, sell_in: 0, quality: 80)
    end
  end
end
