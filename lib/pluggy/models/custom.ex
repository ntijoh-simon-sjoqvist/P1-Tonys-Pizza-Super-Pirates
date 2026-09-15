# defmodule Plyggy.Custom do
#   defstruct(id: nil, ingredients: [])

#   alias Pluggy.Custom

#   def get_custom_orders() do
#         IO.puts("get couston order fugerar")

#     Postgrex.query!(DB, "SELECT order_id, toppings FROM custom_orders")
#     |> IO.inspect()
#     |> get_to_struct
#     |> IO.inspect
#   end

#   def get_to_struct(%Postgrex.Result{rows: rows}) do
#       Enum.map(rows, fn [order_id, toppings] ->
#         %Custom{id: order_id, ingredients: toppings}
#       end)

#   end

# end
