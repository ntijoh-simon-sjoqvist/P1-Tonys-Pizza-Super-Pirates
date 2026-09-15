defmodule Pluggy.Test do

  defstruct( count: nil)

  alias Pluggy.Test


    def count_matches(id) do
    Postgrex.query!(DB, "
    SELECT COUNT(*)
    FROM order_items
    WHERE pizza_id = $1
    GROUP BY pizza_id;", [String.to_integer(id)])
    |> IO.inspect(label: "DATABASE RESULT")
    |> to_struct()


  end

 def to_struct(%Postgrex.Result{rows: rows}) do
  Enum.map(rows, fn [count] ->
    %Test{count: count}
  end)

end



end
