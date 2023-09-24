defmodule WwwArjunsatarkarNet.Router do
  use Plug.Router
  plug(Plug.Logger)
  plug(Plug.Static, at: "/static", from: "site/static")
  plug(:match)
  plug(:dispatch)

  defp put_html_content_type(conn) do
    put_resp_content_type(conn, "text/html")
  end

  get "/" do
    conn
    |> put_html_content_type()
    |> Plug.Conn.send_file(200, "site/index.html")
  end

  match _ do
    conn
    |> put_html_content_type()
    |> Plug.Conn.send_file(404, "site/404.html")
  end

  def start_link do
    {:ok, _} = Plug.Cowboy.http(WwwArjunsatarkarNet.Router, [])
  end
end
