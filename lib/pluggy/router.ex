defmodule Pluggy.Router do
  use Plug.Router
  use Plug.Debugger

  alias Pluggy.PizzaController

  plug(Plug.Static, at: "/", from: :pluggy)
  plug(:put_secret_key_base)

  plug(Plug.Session,
    store: :cookie,
    key: "_my_app_session",
    encryption_salt: "cookie store encryption salt",
    signing_salt: "cookie store signing salt",
    log: :debug
  )

  plug(:fetch_session)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(:put_html_content_type)
  plug(:match)
  plug(:dispatch)


  get("/home", do: PizzaController.index(conn))
  get("/home/basket", do: PizzaController.basket(conn))
  get("/admin", do: PizzaController.admin(conn))
  get("/home/edit", do: PizzaController.edit(conn))


  match _ do
    send_resp(conn, 404, "oop")
  end

  defp put_html_content_type(conn, _), do: put_resp_content_type(conn, "text/html")

  defp put_secret_key_base(conn, _) do
    put_in(
      conn.secret_key_base,
      "-- LONG STRING WITH AT LEAST 64 BYTES LONG STRING WITH AT LEAST 64 BYTES --"
    )
  end
end
