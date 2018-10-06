defmodule Checkout.Utils do
  @doc """
  Return the current number of items in the cart
  """
  @spec get_num_items(Checkout.t()) :: integer
  def get_num_items(co) do
    length(co.items)
  end

  @doc """
  Return the number of a specified item int the cart
  """
  @spec number_of(Checkout.t(), atom()) :: integer
  def number_of(co, item) do
    Enum.reduce(co.items, 0, fn x, acc ->
      if x == item do
        acc + 1
      else
        acc
      end
    end)
  end
end
