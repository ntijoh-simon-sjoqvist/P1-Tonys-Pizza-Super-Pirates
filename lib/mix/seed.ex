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
    Postgrex.query!(DB, "DROP TABLE IF EXISTS order_items", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS orders", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS topping", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza_toppings", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS toppings", [])
  end

  defp create_tables() do
    IO.puts("Creating tables")

    Postgrex.query!(
      DB,
      "CREATE TABLE pizza (id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL, picture_id VARCHAR(255)
      )",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE toppings (id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL
      )",
      []
    )

    Postgrex.query!(
      DB,
    "CREATE TABLE pizza_toppings (
    pizza_id INTEGER REFERENCES pizza(id),
    topping_id INTEGER REFERENCES toppings(id)
    )"
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE orders (id SERIAL PRIMARY KEY,
      status VARCHAR(255)
      )",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE order_items (
      order_id INTEGER REFERENCES orders(id),
      pizza_id INTEGER REFERENCES pizza(id)
      )",
      []
    )
  end

  defp seed_data() do
    IO.puts("Seeding data")

    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Magarhita", "margherita.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Capricciosa", "capricciosa.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Diavola", "diavola.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Marinara", "marinara.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Ortolana", "ortolana.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Prosciutto-e-funghi", "prosciutto-e-funghi.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Quattro-formaggi", "quattro-formaggi.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Quattro-stagioni", "quattro-stagioni.svg"])

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

    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (1, 1), (1, 2), (1, 3)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (2, 1), (2, 2), (2, 4), (2, 5), (2, 6)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (3, 1), (3, 2), (3, 14), (3, 11), (3, 15)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (4, 1)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (5, 1), (5, 2), (5, 11), (5, 12), (5, 13)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (6, 1), (6, 2), (6, 4), (6, 5)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (7, 1), (7, 2), (7, 8), (7, 9), (7, 10)")
    Postgrex.query!(DB, "INSERT INTO pizza_toppings VALUES (8, 1), (8, 2), (8, 5), (8, 6), (8, 7)")


    Postgrex.query!(DB, "INSERT INTO orders (status) VALUES ('cart')")
    Postgrex.query!(DB, "INSERT INTO order_items (order_id, pizza_id) VALUES (1,2)")
    Postgrex.query!(DB, "INSERT INTO order_items (order_id, pizza_id) VALUES (1,3)")

  end
end
