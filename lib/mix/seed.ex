defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run("app.start")
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza-resp", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS topping", [])
  end

  defp create_tables() do
    IO.puts("Creating tables")

    Postgrex.query!(
      DB,
      "CREATE TABLE pizza (id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      picture_id VARCHAR(255)
      )",
      []
    )
    Postgrex.query(
      DB,
      "CREATE TABLE pizza-resp (pizza-id INTEGER NOT NULL,
      toppings VARCHAR(255) NOT NULL
      )",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE topping (id SERIAL PRIMARY KEY,
      name VARCHAR(255)
      )",
      []
    )
  end

  defp seed_data() do
    IO.puts("Seeding data")

    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1", ["Magarhita"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Capricciosa"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Diavola"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Marinara"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Ortolana"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Prodciutto-e-funghi"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Quattro-formaggi"])
    Postgrex.query!(DB, "INSERT INTO pizza(name) VALUES($1)", ["Quattro-stagioni"])

    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["tomatsås"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["mozzarella"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["basilika"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["skinka"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["svamp"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["kronärtskocka"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["oliver"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["parmesan"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["pecorino"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["gorgonzola"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["paprika"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["aubergine"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["zuchini"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["salami"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["chili"])

    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["1", "1, 2, 3"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["2", "1, 2, 4, 5, 6"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["3", "1, 2, 14, 11, 15"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["4", "1"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["5", "1, 2, 11, 12, 13"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["6", "1, 2, 4, 5"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["7", "1, 2, 8, 9, 10"])
    Postgrex.query!(DB, "INSERT INTO pizza-resp(pizza-is, name) VALUES($1, $2)", ["8", "1, 2, 4, 5, 6, 7"])
  end
end
