defmodule GildedRose do
  use Agent

  alias GildedRose.Inventory
  alias GildedRose.Item

  # Use this to toggle between the old, unrefactored code or the newly refactored code:
  @update_quality_fn :update_quality_old_before_refactoring
  # @update_quality_fn :update_quality_newly_refactored

  def item(agent, index) when is_integer(index) do
    agent |> items() |> Enum.at(index)
  end

  def item(agent, start_of_name) when is_binary(start_of_name) do
    agent |> items() |> Enum.find(&String.starts_with?(&1.name, start_of_name))
  end

  def update_n_days(agent, n_days) do
    1..n_days
    |> Enum.map(fn _index ->
      update_quality(agent)
    end)
  end

  def update_quality(agent), do: apply(__MODULE__, @update_quality_fn, [agent])

  def update_quality_newly_refactored(agent) do
    Agent.update(agent, fn items ->
      items |> Enum.map(&Inventory.increment_age_by_1_day(&1))
    end)
  end

  # ================================================================================================
  # Code below this line is the original, unmodified code (other than renaming `update_quality/1`
  # to `update_quality_old_before_refactoring/1`):

  def new() do
    {:ok, agent} =
      Agent.start_link(fn ->
        [
          Item.new("+5 Dexterity Vest", 10, 20),
          Item.new("Aged Brie", 2, 0),
          Item.new("Elixir of the Mongoose", 5, 7),
          Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
          Item.new("Conjured Mana Cake", 3, 6)
        ]
      end)

    agent
  end

  def items(agent), do: Agent.get(agent, & &1)

  def update_quality_old_before_refactoring(agent) do
    for i <- 0..(Agent.get(agent, &length/1) - 1) do
      item = Agent.get(agent, &Enum.at(&1, i))

      item =
        cond do
          item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
            if item.quality > 0 do
              if item.name != "Sulfuras, Hand of Ragnaros" do
                %{item | quality: item.quality - 1}
              else
                item
              end
            else
              item
            end

          true ->
            cond do
              item.quality < 50 ->
                item = %{item | quality: item.quality + 1}

                cond do
                  item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                    item =
                      cond do
                        item.sell_in < 11 ->
                          cond do
                            item.quality < 50 ->
                              %{item | quality: item.quality + 1}

                            true ->
                              item
                          end

                        true ->
                          item
                      end

                    cond do
                      item.sell_in < 6 ->
                        cond do
                          item.quality < 50 ->
                            %{item | quality: item.quality + 1}

                          true ->
                            item
                        end

                      true ->
                        item
                    end

                  true ->
                    item
                end

              true ->
                item
            end
        end

      item =
        cond do
          item.name != "Sulfuras, Hand of Ragnaros" ->
            %{item | sell_in: item.sell_in - 1}

          true ->
            item
        end

      item =
        cond do
          item.sell_in < 0 ->
            cond do
              item.name != "Aged Brie" ->
                cond do
                  item.name != "Backstage passes to a TAFKAL80ETC concert" ->
                    cond do
                      item.quality > 0 ->
                        cond do
                          item.name != "Sulfuras, Hand of Ragnaros" ->
                            %{item | quality: item.quality - 1}

                          true ->
                            item
                        end

                      true ->
                        item
                    end

                  true ->
                    %{item | quality: item.quality - item.quality}
                end

              true ->
                cond do
                  item.quality < 50 ->
                    %{item | quality: item.quality + 1}

                  true ->
                    item
                end
            end

          true ->
            item
        end

      Agent.update(agent, &List.replace_at(&1, i, item))
    end

    :ok
  end
end
