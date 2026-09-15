defmodule Pluggy.PizzaController do
  alias Pluggy.Pizza
  alias Pluggy.Edit
  alias Pluggy.Update
  alias Pluggy.Order
  alias Pluggy.User
  import Pluggy.Template, only: [render: 2, render: 3]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn, id) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

      ingredients = conn.params["ingredients"] || []


    send_resp(conn, 200, render("pizza/index", pizza: Pizza.get_resp(), user: current_user, updatepizzaing: Update.updatepizzaings(id, ingredients) ))
  end


  def index(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    send_resp(conn, 200, render("pizza/index", pizza: Pizza.get_resp(), user: current_user))
  end



  def basket(conn), do: send_resp(conn, 200, render("pizza/basket", pizza: Pizza.all()))
  def admin(conn), do: send_resp(conn, 200, render("pizza/admin.html", [order: Order.get()], false))
  def edit(conn, id), do:  send_resp(conn, 200, render("pizza/edit", ing: Edit.get_ing(), pizza: Edit.get_resp(id)))








end
