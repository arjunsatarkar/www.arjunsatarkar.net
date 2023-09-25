defmodule WwwArjunsatarkarNet.Router do
  alias WwwArjunsatarkarNet.Helpers
  require EEx
  use Plug.Router
  plug(Plug.Logger)

  if Application.compile_env(:www_arjunsatarkar_net, :proxied) == true do
    plug(Plug.RewriteOn, [:x_forwarded_host, :x_forwarded_port, :x_forwarded_proto])
  end

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
    title = "Arjun Satarkar"

    canonical_url =
      URI.to_string(%URI{
        host: conn.host,
        path: conn.request_path,
        port: conn.port,
        scheme: Atom.to_string(conn.scheme)
      })

    head_tags =
      Helpers.generate_head_tags(title, canonical_url, "Arjun Satarkar's home page.")

    conn
    |> put_html_content_type()
    |> send_resp(
      200,
      EEx.eval_file("site/index.html.eex",
        head_tags: head_tags,
        title: title
      )
    )
  end

  get "/favicon.ico" do
    conn
    |> redirect("/static/media/favicon.ico")
  end

  match _ do
    title = "error 404 - page not found"
    head_tags = Helpers.generate_head_tags(title)

    conn
    |> put_html_content_type()
    |> send_resp(
      404,
      EEx.eval_file(
        "site/404.html.eex",
        head_tags: head_tags,
        title: title
      )
    )
  end

  def start_link do
    {:ok, _} = Plug.Cowboy.http(WwwArjunsatarkarNet.Router, [])
  end
end
