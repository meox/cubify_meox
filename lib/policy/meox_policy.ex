defmodule Policy.Meox do
  def new(_store) do
    Policy.new()
    # Rule 1: 1€ discount if total price >= 10€
    |> Policy.add_policy(:one_eur, fn total_price, _co ->
      if total_price >= 10 do
        1
      else
        0
      end
    end)
  end
end
