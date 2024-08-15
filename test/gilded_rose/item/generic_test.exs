defmodule GildedRose.Item.GenericTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  alias GildedRose.Item
  alias GildedRose.Item.Generic

  describe "does the rules for a generic item" do
    test "decreases the quality for each day" do
      item = %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20}

      item = Generic.increment_age_by_1_day(item)

      assert_item(item, sell_in: 9, quality: 19)
    end
  end
end
