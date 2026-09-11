defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "", picture_id: "", pizzaid: nil, resp: "")

  alias Pluggy.Pizza

  def all do
    IO.puts(Postgrex.query!(DB, "SELECT * FROM pizza", []).rows)
    Postgrex.query!(DB, "SELECT * FROM pizza", []).rows
    |> to_struct_list
  end

  def get_resp do
    Postgrex.query!(DB, "SELECT * FROM pizzaresp", [])
    # |> resp

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

  # def resp do

  # end

  def to_struct([[id, name, picture_id]]) do
    %Pizza{id: id, name: name, picture_id: picture_id}
  end

  def to_struct_list(rows) do
    for [id, name, picture_id] <- rows, do: %Pizza{id: id, name: name, picture_id: picture_id}
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
