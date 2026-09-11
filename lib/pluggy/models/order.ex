defmodule Pluggy.Order do
  require IEx
  defstruct(id: nil, status: "", pizzas: [])

  alias Pluggy.Order

  def get(id) do
    x = Postgrex.query!(DB,
    "SELECT orders.*, pizza.*
    FROM orders
    JOIN order_items
    ON order_items.order_id = orders.id
    JOIN pizza
    ON order_items.pizza_id = pizza.id
    WHERE orders.id = $1", [String.to_integer(id)])

    IEx.pry()
    x
    |> to_struct
  end

  def to_struct([[id, status, pizzas]]) do
    %Order{id: id, status: status, pizzas: pizzas}
  end

  def to_struct_list(rows) do
    for [id, status: status, pizzas: pizzas] <- rows, do: %Order{id: id, status: status, pizzas: pizzas}
  end

end
