defmodule Pluggy.Edit do

  defstruct(id: nil, name: "", img: "", ingredients: [])

  alias Pluggy.Edit



 def get_resp(id) do

     Postgrex.query!(
       DB,
       "
       SELECT pizza.*, pizza_toppings.*, toppings.name
       FROM pizza
       JOIN pizza_toppings
         ON pizza.id = pizza_toppings.pizza_id
       JOIN toppings
         ON toppings.id = pizza_toppings.topping_id
         WHERE pizza.id = $1", [String.to_integer(id)]

     )
     |> from_result()
     |> List.first()
     |> IO.inspect()
   end

  def from_result(%Postgrex.Result{rows: rows}) do
    rows
    |> Enum.group_by(fn [_id, _pizza_name, _pic, pizza_id, _topping_id, _topping_name] ->
      pizza_id
    end)
    |> Enum.map(fn {_pizza_id, pizza_rows} ->
      [[id, name, img, _pizza_id, _topping_id, _topping_name] | _] = pizza_rows

      ingredients =
      Enum.map(pizza_rows, fn [_id, _name, _img, _pizza_id, _topping_id, topping_name] ->
        topping_name
      end)

      %Edit{
        id: id,
        name: name,
        img: img,
        ingredients: ingredients
      }

    end)

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
