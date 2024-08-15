defmodule GildedRose.Item.BackstagePassesTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  # "Backstage passes", like aged brie, increases in _quality_ as it's _sell_in_
  # value decreases; _quality_ increases by 2 when there are 10 days or less and
  # by 3 when there are 5 days or less but _quality_ drops to 0 after the concert

  alias GildedRose.Item
  alias GildedRose.Item.BackstagePasses

  describe "the rules for a backstage passes item" do
    test "the quality increase by one if you are more than 15 days out" do
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20}

      item = BackstagePasses.increment_age_by_1_day(item)
      assert_item(item, sell_in: 14, quality: 21)
    end

    test "the quality increases by two if there are 10 days or less" do
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 20}

      item = BackstagePasses.increment_age_by_1_day(item)
      assert_item(item, sell_in: 9, quality: 22)
    end

    test "the quality increases by three if there are 5 days or less" do
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 20}

      item = BackstagePasses.increment_age_by_1_day(item)
      assert_item(item, sell_in: 4, quality: 23)
    end

    test "the quality drops to zero if there are less than zero days" do
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 20}

      item = BackstagePasses.increment_age_by_1_day(item)
      assert_item(item, sell_in: -1, quality: 0)
    end
  end
end
