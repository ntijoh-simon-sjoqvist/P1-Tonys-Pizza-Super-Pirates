defmodule Pluggy.Pizza do
  # require IEx
  defstruct(id: nil, name: "", img: "", ingredients: [])

  alias Pluggy.Pizza

  def all do
    IO.puts(Postgrex.query!(DB, "SELECT * FROM pizza", []).rows)
    Postgrex.query!(DB, "SELECT * FROM pizza", []).rows
    |> to_struct_list
  end

  def get_resp do

    Postgrex.query!(
      DB,
      "
      SELECT pizza.*, pizza_toppings.*, toppings.name
      FROM pizza
      JOIN pizza_toppings
        ON pizza.id = pizza_toppings.pizza_id
      JOIN toppings
        ON toppings.id = pizza_toppings.topping_id
      "
    )
    |> from_result()
  end

  def from_result(%Postgrex.Result{rows: rows}) do
    rows
    |> Enum.group_by(fn [_id, _pizza_name, _pic, pizza_id, _topping_id, _topping_name] ->
      pizza_id
    end)
    |> Enum.map(fn {_pizza_id, pizza_rows} ->
      [[id, name, img, _pizza_id, _topping_id, _topping_name] | _] = pizza_rows

      ingredients =
        Enum.map(pizza_rows, fn [
          _id,
          _name,
          _img,
          _pizza_id,
          _topping_id,
          topping_name
        ] ->
          topping_name
        end)

      %Pizza{
        id: id,
        name: name,
        img: img,
        ingredients: ingredients
      }
    end)
  end




  def get(id) do
    Postgrex.query!(DB, "SELECT * FROM pizza WHERE id = $1 LIMIT 1", [String.to_integer(id)]).rows
    |> to_struct
  end

  def update(id, params) do
    name = params["name"]
    tastiness = String.to_integer(params["tastiness"])
    id = String.to_integer(id)

    Postgrex.query!(
      DB,
      "UPDATE pizza SET name = $1, tastiness = $2 WHERE id = $3",
      [name, tastiness, id]
    )
  end


  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM pizza WHERE id = $1", [String.to_integer(id)])
  end

  def to_struct([[id, name, picture_id]]) do
    %Pizza{id: id, name: name, img: picture_id}
  end

  def to_struct_list(rows) do
    for [id, name, picture_id] <- rows, do: %Pizza{id: id, name: name, img: picture_id}
  end

  def get_ing() do
    IO.puts(Postgrex.query!(DB, "SELECT * FROM toppings", []).rows)
    Postgrex.query!(DB, "SELECT * FROM toppings", []).rows
    |> get_ing_to_struct
  end

  def get_ing_to_struct(rows) do
    for [id, name] <- rows, do: %{id: id, name: name}
  end

end
