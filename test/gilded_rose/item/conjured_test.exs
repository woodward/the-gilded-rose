defmodule GildedRose.Item.ConjuredTest do
  use ExUnit.Case
  import GildedRoseTest.Helpers

  alias GildedRose.Item
  alias GildedRose.Item.Conjured

  if Conjured.new_conjured_behavior?() do
    describe "does the rules for conjured item" do
      # This is the expected behavior based on the README, but not what is in the current code
      test "the quality goes down more quickly - behavior based on README" do
        item = %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 2, quality: 4)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 1, quality: 2)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 0, quality: 0)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -1, quality: 0)
      end

      # This is the expected behavior based on the README, but not what is in the current code
      test "the quality goes down twice as quickly once the sell-in is below zero - behavior based on README" do
        item = %Item{name: "Conjured Mana Cake", sell_in: 1, quality: 12}

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 0, quality: 10)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -1, quality: 6)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -2, quality: 2)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -3, quality: 0)
      end
    end
  else
    describe "does the rules for conjured item" do
      test "the quality goes down more quickly - behavior of the current code (NOT what is descrbed in the README)" do
        item = %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 2}

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 2, quality: 1)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 1, quality: 0)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 0, quality: 0)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -1, quality: 0)
      end

      test "the quality goes down twice as quickly once the sell-in is below zero - behavior of the current code (NOT what is descrbed in the README)" do
        item = %Item{name: "Conjured Mana Cake", sell_in: 1, quality: 6}

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: 0, quality: 5)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -1, quality: 3)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -2, quality: 1)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -3, quality: 0)

        item = Conjured.increment_age_by_1_day(item)
        assert_item(item, sell_in: -4, quality: 0)
      end
    end
  end
end
