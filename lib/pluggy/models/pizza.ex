defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "", picture_id: "")
  alias Pluggy.Pizza

  def all do
    IO.puts(Postgrex.query!(DB, "SELECT * FROM pizza", []).rows)
    Postgrex.query!(DB, "SELECT * FROM pizza", []).rows
    |> to_struct_list

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

  def create(params) do
    name = params["name"]
    tastiness = String.to_integer(params["tastiness"])

    Postgrex.query!(DB, "INSERT INTO pizza (name, tastiness) VALUES ($1, $2)", [name, tastiness])
  end

  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM pizza WHERE id = $1", [String.to_integer(id)])
  end

  def to_struct([[id, name, picture_id]]) do
    %Pizza{id: id, name: name, picture_id: picture_id}
  end

  def to_struct_list(rows) do
    for [id, name, picture_id] <- rows, do: %Pizza{id: id, name: name, picture_id: picture_id}
  end

end
