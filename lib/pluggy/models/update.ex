defmodule Pluggy.Update do

  defstruct(id: nil, ingredients: [])

  alias Pluggy.Update






  def updatepizzaings(id, ingredients) do
     update = %Update{
    id: id,
    ingredients: ingredients
  }

  IO.inspect(update)
end



end
