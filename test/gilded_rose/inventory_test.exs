defmodule GildedRose.InventoryTest do
  use ExUnit.Case

  alias GildedRose.Inventory

  describe "module_name_for_item_type" do
    test "returns AgedBrie for :aged_brie" do
      assert Inventory.module_name_for_item_type(:aged_brie) == GildedRose.Item.AgedBrie
    end
  end
end
