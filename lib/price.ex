defmodule Price do
  @doc """
  Return all items present in our store
  """
  def items() do
    %{
      voucher: {"Cabify Voucher", 5.00},
      tshirt: {"Cabify T-Shirt", 20.00},
      mug: {"Cabify Coffe Mug", 7.50}
    }
  end

  @doc """
  Return the price for the given item.
  Return `default` value in case of the item is not present in the store
  """
  def get_price(items, name, default \\ nil) do
    case Map.get(items, name) do
      nil -> default
      {_, price} -> price
    end
  end
end
