defmodule Pluggy.Update do

  defstruct(id: nil, ingredients: [])

  alias Pluggy.Update






  def updatepizzaings(id, ingredients) do


for ing <- ingredients do
   Postgrex.query!(DB, "INSERT INTO custom_orders(order_id, toppings) VALUES ($1, $2)", [String.to_integer(id), ing])
end



   Postgrex.query!(DB, "SELECT * FROM custom_orders")
   |> IO.inspect()
  end

  # def from_result(%Postgrex.Result{rows: rows}) do

  #   ingredients =
  #     Enum.map(pizza_rows, fn [_id, _name, _img, _pizza_id, _topping_id, topping_name] ->
  #       topping_name
  #     end)
  #     %Update{
  #       id: id,
  #       ingredients: ingredients
  #     }



  # end



end
