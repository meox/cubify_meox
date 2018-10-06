defmodule Policy do
  @doc """
  Create a new (empty) Price Policy
  """
  def new() do
    []
  end

  @doc """
  Add a policy to the current list of Policy

  Usage (apply a discount of 1€ if there is the total price is >= 10€:
  Policy.add_policy(policy_list, :my_new_policy, fn total_price, _co ->
    if total_price >= 10 do
      1
    else
      0
  end)
  """
  @spec add_policy([{atom(), fun()}], atom(), fun()) :: [{atom(), fun()}]
  def add_policy(policy_list, name, predicate_function) do
    [{name, predicate_function} | policy_list]
  end
end
