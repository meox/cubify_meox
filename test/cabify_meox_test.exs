defmodule CabifyMeoxTest do
  use ExUnit.Case
  doctest CabifyMeox

  test "Price::price_list present" do
    items = Price.items()
    assert Price.get_price(items, :mug) != nil
  end

  test "Price::price_list not present" do
    items = Price.items()
    assert Price.get_price(items, :not_present) == nil
  end

  ### test with no price policy
  test "Checkout: adding element" do
    co =
      Policy.new()
      |> Checkout.new()
      |> Checkout.scan(:mug)
      |> Checkout.scan(:mug)
      |> Checkout.scan(:tshirt)

    assert Checkout.Utils.get_num_items(co) == 3
  end

  ### calculate cost of a cart with an empty policy
  test "Checkout: calculate the totale price (no price policy)" do
    store = Price.items()

    co =
      Policy.new()
      |> Checkout.new()
      |> Checkout.scan(:mug)
      |> Checkout.scan(:mug)
      |> Checkout.scan(:tshirt)

    assert Checkout.total(co) ==
             2 * Price.get_price(store, :mug) + Price.get_price(store, :tshirt)
  end

  test "Checkout: calculate the total price 2" do
    store = Price.items()

    co =
      Policy.new()
      |> Checkout.new()
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)

    assert Checkout.total(co) ==
             2 * Price.get_price(store, :voucher) + Price.get_price(store, :tshirt)
  end

  test "Checkout: calculate the total of empty checkout" do
    co =
      Policy.new()
      |> Checkout.new()

    assert Checkout.total(co) == 0
  end

  ### Meox Policy ###
  test "Checkout: calculate the total price using Meox Policy" do
    store = Price.items()

    co =
      store
      |> Policy.Meox.new()
      |> Checkout.new()
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)

    assert Checkout.total(co) ==
             Price.get_price(store, :voucher) + Price.get_price(store, :tshirt) - 1
  end

  test "Checkout: calculate the total price using Meox Policy (not apply)" do
    store = Price.items()

    co =
      store
      |> Policy.Meox.new()
      |> Checkout.new()
      |> Checkout.scan(:mug)

    assert Checkout.total(co) == Price.get_price(store, :mug)
  end

  ### Cabify Policy ###
  test "Checkout: calculate the total price (2x1 policy)" do
    store = Price.items()

    co =
      store
      |> Policy.Cabify.new()
      |> Checkout.new()
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)

    assert Checkout.total(co) ==
             Price.get_price(store, :voucher) + Price.get_price(store, :tshirt)
  end

  test "Checkout: calculate the total price (ex 1)" do
    co =
      Price.items()
      |> Policy.Cabify.new()
      |> Checkout.new()
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:mug)

    assert Checkout.total(co) == 32.50
  end

  test "Checkout: calculate the total price (ex 2)" do
    co =
      Price.items()
      |> Policy.Cabify.new()
      |> Checkout.new()
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:voucher)

    assert Checkout.total(co) == 25.00
  end

  test "Checkout: calculate the total price (ex 3)" do
    co =
      Price.items()
      |> Policy.Cabify.new()
      |> Checkout.new()
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)

    assert Checkout.total(co) == 81.00
  end

  test "Checkout: calculate the total price (ex 4)" do
    co =
      Price.items()
      |> Policy.Cabify.new()
      |> Checkout.new()
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:voucher)
      |> Checkout.scan(:mug)
      |> Checkout.scan(:tshirt)
      |> Checkout.scan(:tshirt)

    assert Checkout.total(co) == 74.50
  end
end
