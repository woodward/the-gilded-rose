defmodule GildedRoseTest do
  use ExUnit.Case

  alias GildedRose.Item

  test "interface specification" do
    gilded_rose = GildedRose.new()
    [%Item{} | _] = GildedRose.items(gilded_rose)
    assert :ok == GildedRose.update_quality(gilded_rose)
  end

  # ================================================================================================
  # Everything below this line has been added as additional test coverage

  describe "overall behavior" do
    setup do
      gilded_rose = GildedRose.new()
      [gilded_rose: gilded_rose]
    end

    test "the order of the items does not change with updates", %{gilded_rose: gilded_rose} do
      initial_items = GildedRose.items(gilded_rose)
      original_order = initial_items |> Enum.map(& &1.name)

      assert :ok == GildedRose.update_quality(gilded_rose)

      items = GildedRose.items(gilded_rose)
      order_after_update = items |> Enum.map(& &1.name)
      assert order_after_update == original_order
    end

    test "document the overall existing behavior", %{gilded_rose: gilded_rose} do
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

      1..50 |> Enum.each(fn _index -> assert :ok == GildedRose.update_quality(gilded_rose) end)

      step54 = GildedRose.items(gilded_rose)
      assert step54 == expected_step54()
    end
  end

  describe "add an item/2 function (to aid in testing)" do
    setup do
      gilded_rose = GildedRose.new()
      [gilded_rose: gilded_rose]
    end

    test "returns the element at the nth element", %{gilded_rose: gilded_rose} do
      dexterity_vest = GildedRose.item(gilded_rose, 0)
      assert dexterity_vest.name == "+5 Dexterity Vest"

      mongoose = GildedRose.item(gilded_rose, 2)
      assert mongoose.name == "Elixir of the Mongoose"
    end

    test "works with the start of a name", %{gilded_rose: gilded_rose} do
      dexterity_vest = GildedRose.item(gilded_rose, "+5 Dexterity")
      assert dexterity_vest.name == "+5 Dexterity Vest"

      mongoose = GildedRose.item(gilded_rose, "Elixir")
      assert mongoose.name == "Elixir of the Mongoose"
    end
  end

  describe "update_n_days" do
    setup do
      gilded_rose = GildedRose.new()
      [gilded_rose: gilded_rose]
    end

    test "does a multi-date update", %{gilded_rose: gilded_rose} do
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

  describe "quality checks" do
    setup do
      gilded_rose = GildedRose.new()
      [gilded_rose: gilded_rose]
    end

    test "+5 Dexterity Vest - decreases quality and sell-in days", %{gilded_rose: gilded_rose} do
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

    test "the quality stays 0 or above - dexterity vest", %{gilded_rose: gilded_rose} do
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: 10, quality: 20)

      GildedRose.update_n_days(gilded_rose, 100)
      assert_item("+5 Dexterity Vest", gilded_rose, sell_in: -90, quality: 0)
    end

    test "the quality stays 0 or above - aged brie - and maxes out at 50", %{
      gilded_rose: gilded_rose
    } do
      assert_item("Aged Brie", gilded_rose, sell_in: 2, quality: 0)

      delta_quality = 1

      1..2
      |> Enum.reduce({1, 1}, fn _index, {quality, sell_in} ->
        GildedRose.update_n_days(gilded_rose, 1)
        assert_item("Aged Brie", gilded_rose, sell_in: sell_in, quality: quality)
        {quality + delta_quality, sell_in - 1}
      end)

      delta_quality = 2

      3..26
      |> Enum.reduce({4, -1}, fn _index, {quality, sell_in} ->
        GildedRose.update_n_days(gilded_rose, 1)
        assert_item("Aged Brie", gilded_rose, sell_in: sell_in, quality: quality)
        {quality + delta_quality, sell_in - 1}
      end)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Aged Brie", gilded_rose, sell_in: -25, quality: 50)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Aged Brie", gilded_rose, sell_in: -26, quality: 50)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Aged Brie", gilded_rose, sell_in: -27, quality: 50)
    end

    test "quality for Elixir of the Mongoose", %{gilded_rose: gilded_rose} do
      assert_item("Elixir", gilded_rose, sell_in: 5, quality: 7)

      quality_delta = -1

      1..5
      |> Enum.reduce({6, 4}, fn _index, {quality, sell_in} ->
        GildedRose.update_n_days(gilded_rose, 1)
        assert_item("Elixir", gilded_rose, sell_in: sell_in, quality: quality)
        {quality + quality_delta, sell_in - 1}
      end)

      # Note that when the sell_in is -1 then the quality goes down by 2, not 1

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Elixir", gilded_rose, sell_in: -1, quality: 0)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Elixir", gilded_rose, sell_in: -2, quality: 0)
    end

    @tag :skip
    test "quality for conjured items - expected based on README", %{gilded_rose: gilded_rose} do
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 3, quality: 6)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 2, quality: 4)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 1, quality: 2)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 0, quality: 0)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: -1, quality: 0)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: -2, quality: 0)
    end

    test "quality for conjured items - actual current", %{gilded_rose: gilded_rose} do
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 3, quality: 6)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 2, quality: 5)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 1, quality: 4)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: 0, quality: 3)

      # Note the decrease in 2 of quality (because sell_in is -1?)
      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: -1, quality: 1)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: -2, quality: 0)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Conjured Mana Cake", gilded_rose, sell_in: -3, quality: 0)
    end

    test "quality for Sulfuras - quality never goes down, and sell-in does not decrease", %{
      gilded_rose: gilded_rose
    } do
      assert_item("Sulfuras", gilded_rose, sell_in: 0, quality: 80)

      GildedRose.update_n_days(gilded_rose, 100)
      assert_item("Sulfuras", gilded_rose, sell_in: 0, quality: 80)
    end

    test "quality for Backstage passes - quality increases, and then goes to zero", %{
      gilded_rose: gilded_rose
    } do
      # Quality increases by 1:
      assert_item("Backstage passes", gilded_rose, sell_in: 15, quality: 20)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: 14, quality: 21)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: 13, quality: 22)

      GildedRose.update_n_days(gilded_rose, 3)
      assert_item("Backstage passes", gilded_rose, sell_in: 10, quality: 25)

      # Quality increases by 2 when there are 10 days or less:
      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: 9, quality: 27)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: 8, quality: 29)

      GildedRose.update_n_days(gilded_rose, 3)
      assert_item("Backstage passes", gilded_rose, sell_in: 5, quality: 35)

      # Quality increases by 3 when there are 5 days or less:
      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: 4, quality: 38)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: 3, quality: 41)

      GildedRose.update_n_days(gilded_rose, 3)
      assert_item("Backstage passes", gilded_rose, sell_in: 0, quality: 50)

      # Quality drops to zero when the concert is over:
      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: -1, quality: 0)

      GildedRose.update_n_days(gilded_rose, 1)
      assert_item("Backstage passes", gilded_rose, sell_in: -2, quality: 0)
    end
  end

  def assert_item(name, gilded_rose, opts) do
    sell_in = Keyword.get(opts, :sell_in)
    quality = Keyword.get(opts, :quality)
    item = GildedRose.item(gilded_rose, name)

    assert item.sell_in == sell_in
    assert item.quality == quality
  end

  # ================================================================================================

  def initial do
    [
      %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
      %Item{name: "Aged Brie", sell_in: 2, quality: 0},
      %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20},
      %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}
    ]
  end

  def expected_step1 do
    [
      %Item{name: "+5 Dexterity Vest", sell_in: 9, quality: 19},
      %Item{name: "Aged Brie", sell_in: 1, quality: 1},
      %Item{name: "Elixir of the Mongoose", sell_in: 4, quality: 6},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 14, quality: 21},
      %Item{name: "Conjured Mana Cake", sell_in: 2, quality: 5}
    ]
  end

  def expected_step2 do
    [
      %Item{name: "+5 Dexterity Vest", sell_in: 8, quality: 18},
      %Item{name: "Aged Brie", sell_in: 0, quality: 2},
      %Item{name: "Elixir of the Mongoose", sell_in: 3, quality: 5},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 13, quality: 22},
      %Item{name: "Conjured Mana Cake", sell_in: 1, quality: 4}
    ]
  end

  def expected_step3 do
    [
      %Item{name: "+5 Dexterity Vest", sell_in: 7, quality: 17},
      %Item{name: "Aged Brie", sell_in: -1, quality: 4},
      %Item{name: "Elixir of the Mongoose", sell_in: 2, quality: 4},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 12, quality: 23},
      %Item{name: "Conjured Mana Cake", sell_in: 0, quality: 3}
    ]
  end

  def expected_step4 do
    [
      %Item{name: "+5 Dexterity Vest", sell_in: 6, quality: 16},
      %Item{name: "Aged Brie", sell_in: -2, quality: 6},
      %Item{name: "Elixir of the Mongoose", sell_in: 1, quality: 3},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 11, quality: 24},
      %Item{name: "Conjured Mana Cake", sell_in: -1, quality: 1}
    ]
  end

  def expected_step54 do
    [
      %Item{name: "+5 Dexterity Vest", quality: 0, sell_in: -44},
      %Item{name: "Aged Brie", quality: 50, sell_in: -52},
      %Item{name: "Elixir of the Mongoose", quality: 0, sell_in: -49},
      %Item{name: "Sulfuras, Hand of Ragnaros", quality: 80, sell_in: 0},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 0, sell_in: -39},
      %Item{name: "Conjured Mana Cake", quality: 0, sell_in: -51}
    ]
  end
end
