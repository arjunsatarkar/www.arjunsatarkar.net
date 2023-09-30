defmodule WwwArjunsatarkarNet.Router do
  require WwwArjunsatarkarNet.Cache
  alias WwwArjunsatarkarNet.Cache
  alias WwwArjunsatarkarNet.Template
  alias WwwArjunsatarkarNet.Helpers
  use Plug.Router
  plug(Plug.Logger)

  if Application.compile_env(:www_arjunsatarkar_net, :proxied) do
    plug(Plug.RewriteOn, [:x_forwarded_host, :x_forwarded_port, :x_forwarded_proto])
  end

  plug(Plug.Head)

  # Handle just the scripts first so we can make sure charset is UTF-8.
  plug(Plug.Static,
    at: "/static/scripts",
    from: "site/static/scripts",
    headers: %{"Content-Type" => "text/javascript; charset=utf-8"}
  )

  plug(Plug.Static, at: "/static", from: "site/static")
  plug(:match)
  plug(:dispatch)

  @spec put_html_content_type(Plug.Conn.t()) :: Plug.Conn.t()
  defp put_html_content_type(conn) do
    put_resp_content_type(conn, "text/html")
  end

  @spec redirect(Plug.Conn.t(), binary) :: Plug.Conn.t()
  defp redirect(conn, dest) do
    conn
    |> put_resp_header("Location", dest)
    |> send_resp(302, "")
  end

  get "/" do
    canonical_url =
      URI.to_string(%URI{
        host: conn.host,
        path: "/",
        port: conn.port,
        scheme: Atom.to_string(conn.scheme)
      })

    page =
      Cache.get_cached("/",
        else:
          Template.eval_compiled("site/index.html.eex",
            canonical_url: canonical_url,
            generate_head_tags: &Helpers.generate_head_tags/3
          )
      )

    conn
    |> put_html_content_type()
    |> send_resp(
      200,
      page
    )
  end

  get "/favicon.ico" do
    conn
    |> redirect("/static/media/favicon.ico")
  end

  match _ do
    page =
      Cache.get_cached("@404",
        else:
          Template.eval_compiled("site/404.html.eex",
            generate_head_tags: &Helpers.generate_head_tags/1
          )
      )

    conn
    |> put_html_content_type()
    |> send_resp(
      404,
      page
    )
  end

  def start_link do
    {:ok, _} = Plug.Cowboy.http(WwwArjunsatarkarNet.Router, [])
  end
end
