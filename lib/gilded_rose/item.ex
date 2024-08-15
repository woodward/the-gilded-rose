defmodule GildedRose.Item do
  @moduledoc false

  @type t :: %__MODULE__{
          name: String.t(),
          sell_in: integer(),
          quality: GildedRose.Quality.t()
        }

  defstruct [
    :name,
    :sell_in,
    :quality
  ]

  def new(name, sell_in, quality) do
    %__MODULE__{name: name, sell_in: sell_in, quality: quality}
  end
end
