defmodule Pluggy.Update do

  defstruct(id: nil, ingredients: [], count: nil)



  alias Pluggy.Update


  def count_matches(id) do
    Postgrex.query!(DB, "
    SELECT pizza_id, COUNT(*)
    FROM order_items
    WHERE order_id = $1
    GROUP BY pizza_id", [String.to_integer(id)])
    |> to_struct()



  end

  def to_struct(count) do
    %Update{count: count}
  end





  def updatepizzaings(id, ingredients) do
     update = %Update{
    id: id,
    ingredients: ingredients
  }

  IO.inspect(update)
end



end
