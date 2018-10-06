# CabifyMeox

Cabify Exercise

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cabify_meox` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cabify_meox, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cabify_meox](https://hexdocs.pm/cabify_meox).

## Usage

```elixir
    co =
      # load items from the store
      Price.items()
      |> CabifyPolicy.new()
      # create the checkout using a specific policy
      |> Checkout.new()
      # add several items
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)

    # calculate the final price
    assert Checkout.total(co) == 81.00
```

## Test

- mix deps.get
- mix compile
- mix dyalizer
- mix test
