defmodule Pluggy.Update do

  defstruct(id: nil, ingredients: [])

  alias Pluggy.Update


  def updatepizzaings(id, ingredients) do


  for ing <- ingredients do
    Postgrex.query!(DB, "INSERT INTO custom_orders(order_id, toppings) VALUES ($1, $2)", [String.to_integer(id), ing])
   end



  end
end
