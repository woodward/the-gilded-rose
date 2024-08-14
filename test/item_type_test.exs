defmodule ItemTypeTest do
  use ExUnit.Case

  alias GildedRose.ItemType

  describe "new/1" do
    test "converts the item name to an item type - generic item" do
      assert ItemType.new("+5 Dexterity Vest") == :generic
    end

    test "converts the item name to an item type - conjured" do
      assert ItemType.new("Conjured Mana Cake") == :conjured
      assert ItemType.new("conjured Moon cake") == :conjured
    end

    test "converts the item name to an item type - backstage pass" do
      assert ItemType.new("Backstage passes to a TAFKAL80ETC concert") == :backstage_passes
      assert ItemType.new("backstage passes for some concert") == :backstage_passes
    end

    test "converts the item name to an item type - sulfuras" do
      assert ItemType.new("Sulfuras, Hand of Ragnaros") == :sulfuras
      assert ItemType.new("sulfuras blah") == :sulfuras
    end

    test "converts the item name to an item type - aged brie" do
      assert ItemType.new("Aged Brie") == :aged_brie
      assert ItemType.new("aged brie") == :aged_brie
    end

    test "converts the item name to an item type - Elixir of the Mongoose" do
      assert ItemType.new("Elixir of the Mongoose") == :generic
      assert ItemType.new("elixir of the ruby") == :generic
    end
  end
end
