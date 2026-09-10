defmodule Pluggy.PizzaController do
  alias Pluggy.Pizza
  alias Pluggy.User
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    send_resp(conn, 200, render("pizza/index", pizza: Pizza.all(), user: current_user))
  end

    def new(conn), do: send_resp(conn, 200, render("pizza/new.html", []))

end
