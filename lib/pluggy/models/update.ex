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
    |> List.first

  end

 def to_struct(%Postgrex.Result{rows: rows}) do
  Enum.map(rows, fn [pizza_id, count] ->
    %Update{id: pizza_id, count: count}
  end)
end

  def updatepizzaings(id, ingredients) do
     update = %Update{
    id: id,
    ingredients: ingredients
  }

  IO.inspect(update)
end



end
