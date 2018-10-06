defmodule Checkout do
  defstruct(
    price_policy: [],
    items: []
  )

  @type t :: %Checkout{price_policy: [any()], items: [atom()]}

  @doc """
  Create an empty Checkout with a given policy
  """
  @spec new([any()]) :: Checkout.t()
  def new(price_policy) do
    %Checkout{price_policy: price_policy}
  end

  @doc """
  Add an object to the current Checkout
  """
  @spec scan(Checkout.t(), atom()) :: Checkout.t()
  def scan(co, item) do
    %{co | items: [item | co.items]}
  end

  @doc """
  Calculate the total price (with discount applied)
  """
  @spec total(Checkout.t()) :: number()
  def total(co) do
    Price.items()
    |> calculate_total(co)
    |> with_discount(co)
  end

  ### PRIVATE ###

  # Calculate the total price without any discount
  defp calculate_total(store, co) do
    co.items
    |> Enum.reduce(0, fn item, acc ->
      acc + Price.get_price(store, item)
    end)
  end

  # Apply the discount policy in the current cart
  defp with_discount(total_price, co) do
    discount =
      co.price_policy
      |> Enum.reduce(0, fn {_policy_name, fn_policy}, acc ->
        acc + fn_policy.(total_price, co)
      end)

    # Note: we need to understand here what happens if the final discount
    #       is greater than total_price
    total_price - discount
  end
end
