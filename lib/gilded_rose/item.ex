defmodule GildedRose.Item do
  @moduledoc """
  OK, so I know that we're not supposed to modify this file (so sue me), but the only thing I added
  was a type `t()` which helps out the dialyzer.
  """

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
