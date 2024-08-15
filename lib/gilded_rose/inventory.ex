defmodule GildedRose.Inventory do
  @moduledoc false

  alias GildedRose.Item
  alias GildedRose.ItemType

  @callback increment_age_by_1_day(Item.t()) :: Item.t()

  def increment_age_by_1_day(item) do
    item_module = item.name |> ItemType.new() |> module_name_for_item_type()
    apply(item_module, :increment_age_by_1_day, [item])
  end

  @spec module_name_for_item_type(ItemType.t()) :: module()
  def module_name_for_item_type(item_type) do
    module = item_type |> Atom.to_string() |> Macro.camelize()
    Module.concat([Item, module])
  end
end
