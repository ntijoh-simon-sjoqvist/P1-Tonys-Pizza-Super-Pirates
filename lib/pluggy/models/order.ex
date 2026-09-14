defmodule Pluggy.Order do
  # require IEx
  defstruct(id: nil, status: "", pizzas: [])

  alias Pluggy.Order

  def get() do
    Postgrex.query!(DB,
    "SELECT orders.*, pizza.name
    FROM orders
    JOIN order_items
    ON order_items.order_id = orders.id
    JOIN pizza
    ON order_items.pizza_id = pizza.id
    ")
    |> from_result()
  end

  def from_result(%Postgrex.Result{rows: rows}) do
    rows
    |> Enum.group_by(fn [order_id, _status, _pizza_name] ->
      order_id
    end)
    |> Enum.map(fn {_order_id, order_rows} ->
      [[id, status, _pizza_name] | _] = order_rows

      pizzas =
        Enum.map(order_rows, fn [
          _id,
          _status,
          pizza_name
        ] ->
          pizza_name
        end)

      %Order{
        id: id,
        status: status,
        pizzas: pizzas
      }
    end)
  end

  def update(pizza_id) do
    IO.puts(pizza_id)
    Postgrex.query!(DB,"INSERT INTO orders(status) VALUES ($1)", [])
    Postgrex.query!(DB, "INSERT INTO order_items(order_id, pizza_id) VALUES ($1, $2)", [1, pizza_id])
  end

end

