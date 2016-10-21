defmodule GotBot.Router do
  use Trot.Router

  get "/", do: "Up and running"

  post "/webhook" do
    {:ok, data, _none} = Plug.Conn.read_body(conn)
    {:ok, data} = JSX.decode data

    if data["message"]["chat"] != nil do
      id   = data["message"]["chat"]["id"]
      text = data["message"]["text"]
      from = data["message"]["from"]["first_name"]

      # final_message = GotBot.Handler.perform text
      final_message = "Did you sent: #{text} to me, #{from} ?"
      Nadia.send_message(id, final_message)
    end
  end

  import_routes Trot.NotFound
end
