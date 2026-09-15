defmodule Pluggy.Basket do
defstruct(id: nil, name: "", img: "", count: nil)

alias Pluggy.Basket

  def get() do
    Postgrex.query!(
      DB,
      "SELECT pizza.id, pizza.name,
      MIN(pizza.picture_id) AS picture_id,
      COUNT(order_items.pizza_id) AS count
      FROM order_items
      JOIN pizza
      ON order_items.pizza_id = pizza.id
      GROUP BY pizza.id
      "
    )
    |> from_result()
  end

  def from_result(%Postgrex.Result{rows: rows}) do
  rows
  |> Enum.group_by(fn [id, _name, _img, _count] ->
      id
    end)
    |> Enum.map(fn {_id, basket_rows} ->
      [[id, name, img, _count] | _] = basket_rows

      count =
        Enum.map(basket_rows, fn [
          _id,
          _name,
          _img,
          count
        ] ->
          count
        end)

      %Basket{
        id: id,
        name: name,
        img: img,
        count: count
      }
    end)
  end

  def update(id) do
    Postgrex.query!(DB, "INSERT INTO order_items(order_id, pizza_id) VALUES ($1, $2)", [1, String.to_integer(id)])
  end
end
