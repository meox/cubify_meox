defmodule Policy.Cabify do
  @moduledoc """
  This module implements the rules specified by CFO and Marketing departement
  """

  alias Checkout.Utils

  def new(store) do
    Policy.new()
    # Rule 1: VOUCHER 2x1
    |> Policy.add_policy(:voucher_2x1, fn _total_price, co ->
      if Utils.number_of(co, :voucher) >= 2 do
        Price.get_price(store, :voucher)
      else
        0
      end
    end)
    # Rule 2: Discount on T-Shirt if acquired in bulk (>= 3)
    |> Policy.add_policy(:cfo, fn _total_price, co ->
      n_tshirt = Utils.number_of(co, :tshirt)

      if n_tshirt >= 3 do
        n_tshirt * (Price.get_price(store, :tshirt) - 19)
      else
        0
      end
    end)
  end
end
