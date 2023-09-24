defmodule WwwArjunsatarkarNet.Router do
  require EEx
  use Plug.Router
  plug(Plug.Logger)
  plug(Plug.Head)
  plug(Plug.Static, at: "/static", from: "site/static")
  plug(:match)
  plug(:dispatch)

  defp put_html_content_type(conn) do
    put_resp_content_type(conn, "text/html")
  end

  defp redirect(conn, dest) do
    put_resp_header(conn, "Location", dest)
    |> send_resp(302, "")
  end

  get "/" do
    canonical_url = Atom.to_string(conn.scheme) <> "://" <> conn.host <> conn.request_path

    conn
    |> put_html_content_type()
    |> send_resp(
      200,
      EEx.eval_file("site/index.html.eex",
        generate_head_tags: &WwwArjunsatarkarNet.Helpers.generate_head_tags/3,
        canonical_url: canonical_url
      )
    )
  end

  get "/favicon.ico" do
    conn
    |> redirect("/static/media/favicon.ico")
  end

  match _ do
    conn
    |> put_html_content_type()
    |> send_resp(
      404,
      EEx.eval_file("site/404.html.eex",
        generate_head_tags: &WwwArjunsatarkarNet.Helpers.generate_head_tags/3
      )
    )
  end

  def start_link do
    {:ok, _} = Plug.Cowboy.http(WwwArjunsatarkarNet.Router, [])
  end
end
