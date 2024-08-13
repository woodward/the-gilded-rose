defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  alias GildedRose.Item

  test "interface specification" do
    gilded_rose = GildedRose.new()
    [%GildedRose.Item{} | _] = GildedRose.items(gilded_rose)
    assert :ok == GildedRose.update_quality(gilded_rose)
  end

  describe "overall behavior" do
    test "document the existing behavior" do
      gilded_rose = GildedRose.new()
      initial_items = GildedRose.items(gilded_rose)
      assert initial_items == initial()

      # -----------------------
      assert :ok == GildedRose.update_quality(gilded_rose)
      step1 = GildedRose.items(gilded_rose)
      assert step1 == expected_step1()

      # -----------------------
      assert :ok == GildedRose.update_quality(gilded_rose)
      step2 = GildedRose.items(gilded_rose)
      assert step2 == expected_step2()

      # -----------------------
      assert :ok == GildedRose.update_quality(gilded_rose)
      step3 = GildedRose.items(gilded_rose)
      assert step3 == expected_step3()

      # -----------------------
      assert :ok == GildedRose.update_quality(gilded_rose)
      step4 = GildedRose.items(gilded_rose)
      assert step4 == expected_step4()
    end
  end

  describe "add an item/2 function (to aid in testing)" do
    test "returns the element at the nth element" do
      gilded_rose = GildedRose.new()

      dexterity_vest = GildedRose.item(gilded_rose, 0)
      assert dexterity_vest.name == "+5 Dexterity Vest"

      mongoose = GildedRose.item(gilded_rose, 2)
      assert mongoose.name == "Elixir of the Mongoose"
    end

    test "works with the start of a name" do
      gilded_rose = GildedRose.new()

      dexterity_vest = GildedRose.item(gilded_rose, "+5 Dexterity")
      assert dexterity_vest.name == "+5 Dexterity Vest"

      mongoose = GildedRose.item(gilded_rose, "Elixir")
      assert mongoose.name == "Elixir of the Mongoose"
    end
  end

  describe "update_n_days" do
    test "does a multi-date update" do
      gilded_rose = GildedRose.new()
      dexterity = GildedRose.item(gilded_rose, 0)
      assert dexterity == %Item{name: "+5 Dexterity Vest", quality: 20, sell_in: 10}

      GildedRose.update_n_days(gilded_rose, 10)

      assert GildedRose.item(gilded_rose, 0) == %Item{
               name: "+5 Dexterity Vest",
               quality: 10,
               sell_in: 0
             }
    end
  end

  describe "+5 Dexterity Vest" do
    test "decreases quality and sell-in days" do
      gilded_rose = GildedRose.new()
      dexterity = GildedRose.item(gilded_rose, 0)
      assert dexterity == %Item{name: "+5 Dexterity Vest", quality: 20, sell_in: 10}
      GildedRose.update_n_days(gilded_rose, 10)
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: 0, quality: 10)

      assert :ok == GildedRose.update_quality(gilded_rose)

      # Negative sell-in: now quality goes down by 2 each day:
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: -1, quality: 8)

      assert :ok == GildedRose.update_quality(gilded_rose)
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: -2, quality: 6)

      GildedRose.update_n_days(gilded_rose, 3)
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: -5, quality: 0)

      assert :ok == GildedRose.update_quality(gilded_rose)

      # Quality never goes below zero:
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: -6, quality: 0)
    end
  end

  describe "the quality is never negative" do
    test "the quality stays 0 or above - dexterity vest" do
      gilded_rose = GildedRose.new()
      assert GildedRose.item(gilded_rose, 0).quality == 20
      GildedRose.update_n_days(gilded_rose, 100)
      assert GildedRose.item(gilded_rose, 0).quality == 0
    end

    @tag :skip
    test "the quality stays 0 or above - aged brie - and maxes out at 50" do
      gilded_rose = GildedRose.new()
      _aged_brie = GildedRose.item(gilded_rose, 1)
      GildedRose.update_n_days(gilded_rose, 49)
      assert GildedRose.item(gilded_rose, 1).quality == 50
    end
  end

  # ================================================================================================

  def initial do
    [
      %GildedRose.Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
      %GildedRose.Item{name: "Aged Brie", sell_in: 2, quality: 0},
      %GildedRose.Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
      %GildedRose.Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %GildedRose.Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 15,
        quality: 20
      },
      %GildedRose.Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}
    ]
  end

  def expected_step1 do
    [
      %GildedRose.Item{name: "+5 Dexterity Vest", sell_in: 9, quality: 19},
      %GildedRose.Item{name: "Aged Brie", sell_in: 1, quality: 1},
      %GildedRose.Item{name: "Elixir of the Mongoose", sell_in: 4, quality: 6},
      %GildedRose.Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %GildedRose.Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 14,
        quality: 21
      },
      %GildedRose.Item{name: "Conjured Mana Cake", sell_in: 2, quality: 5}
    ]
  end

  def expected_step2 do
    [
      %GildedRose.Item{name: "+5 Dexterity Vest", sell_in: 8, quality: 18},
      %GildedRose.Item{name: "Aged Brie", sell_in: 0, quality: 2},
      %GildedRose.Item{name: "Elixir of the Mongoose", sell_in: 3, quality: 5},
      %GildedRose.Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %GildedRose.Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 13,
        quality: 22
      },
      %GildedRose.Item{name: "Conjured Mana Cake", sell_in: 1, quality: 4}
    ]
  end

  def expected_step3 do
    [
      %GildedRose.Item{name: "+5 Dexterity Vest", sell_in: 7, quality: 17},
      %GildedRose.Item{name: "Aged Brie", sell_in: -1, quality: 4},
      %GildedRose.Item{name: "Elixir of the Mongoose", sell_in: 2, quality: 4},
      %GildedRose.Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %GildedRose.Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 12,
        quality: 23
      },
      %GildedRose.Item{name: "Conjured Mana Cake", sell_in: 0, quality: 3}
    ]
  end

  def expected_step4 do
    [
      %GildedRose.Item{name: "+5 Dexterity Vest", sell_in: 6, quality: 16},
      %GildedRose.Item{name: "Aged Brie", sell_in: -2, quality: 6},
      %GildedRose.Item{name: "Elixir of the Mongoose", sell_in: 1, quality: 3},
      %GildedRose.Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %GildedRose.Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 11,
        quality: 24
      },
      %GildedRose.Item{name: "Conjured Mana Cake", sell_in: -1, quality: 1}
    ]
  end

  def assert_item(name, gilded_rose, opts) do
    sell_in = Keyword.get(opts, :sell_in)
    quality = Keyword.get(opts, :quality)
    item = GildedRose.item(gilded_rose, name)

    assert item.sell_in == sell_in
    assert item.quality == quality
  end
end
