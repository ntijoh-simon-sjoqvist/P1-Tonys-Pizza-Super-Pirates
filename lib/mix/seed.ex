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

    Postgrex.query!(DB, "INSERT INTO pizza(name, picture_id) VALUES($1, $2)", ["Magarhita", "margherita.svg"])

    Postgrex.query!(DB, "INSERT INTO fruits(name, tastiness) VALUES($1, $2)", ["Apple", 5])
    Postgrex.query!(DB, "INSERT INTO fruits(name, tastiness) VALUES($1, $2)", ["Pear", 4])
    Postgrex.query!(DB, "INSERT INTO fruits(name, tastiness) VALUES($1, $2)", ["Banana", 7])

    Postgrex.query!(
      DB,
      "INSERT INTO users(username, password_hash) VALUES($1, $2)",
      ["a", Bcrypt.hash_pwd_salt("a")]
    )
  end
end
