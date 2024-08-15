defmodule GildedRose.QualityTest do
  use ExUnit.Case

  alias GildedRose.Quality

  describe "increase_by_one/1" do
    test "increases the age by one" do
      assert Quality.increase_by_one(10) == 11
    end

    test "maxes out at 50" do
      assert Quality.increase_by_one(49) == 50
      assert Quality.increase_by_one(50) == 50
    end
  end

  describe "increase_by_two/1" do
    test "increases the age by two" do
      assert Quality.increase_by_two(10) == 12
    end

    test "maxes out at 50" do
      assert Quality.increase_by_two(48) == 50
      assert Quality.increase_by_two(49) == 50
      assert Quality.increase_by_two(50) == 50
    end
  end

  describe "decrease_by_one/1" do
    test "decreases the age by one" do
      assert Quality.decrease_by_one(10) == 9
    end

    test "does not go below zero" do
      assert Quality.decrease_by_one(1) == 0
      assert Quality.decrease_by_one(0) == 0
    end
  end

  describe "decrease_by_two/1" do
    test "decreases the age by two" do
      assert Quality.decrease_by_two(10) == 8
    end

    test "does not go below zero" do
      assert Quality.decrease_by_two(2) == 0
      assert Quality.decrease_by_two(1) == 0
      assert Quality.decrease_by_two(0) == 0
    end
  end
end
