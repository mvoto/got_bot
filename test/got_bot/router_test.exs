defmodule RouterTest do
  use ExUnit.Case
  use Plug.Test
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias GotBot.Router

  @opts Router.init([])

  describe "get '/'" do
    test "success request" do
      conn = conn(:get, "/")
      response = Router.call(conn, @opts)

      assert response.status == 200
      assert response.resp_body == "Up and running"
    end
  end

  describe "post '/webhook'" do
    test "success request" do
      params = %{
        message: %{
          from: %{first_name: "Mauricio"},
          text: "Hi bot !",
          chat: %{id: 191774605}
        }
      }
      use_cassette "send_message" do
        conn = conn(:post, "/webhook", Poison.encode!(params))
        |> put_req_header("content-type", "application/json")
        |> Router.call(@opts)

        {:ok, parsed_body} = JSX.decode(conn.resp_body)

        assert parsed_body["text"] == "Did you sent: Hi bot ! to me, Mauricio ?"
      end
    end
  end
end
