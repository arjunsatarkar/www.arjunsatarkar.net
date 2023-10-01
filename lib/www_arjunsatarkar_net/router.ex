defmodule WwwArjunsatarkarNet.Router do
  alias WwwArjunsatarkarNet.Cache
  alias WwwArjunsatarkarNet.Helpers
  require WwwArjunsatarkarNet.Cache
  require Logger
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

  get "/" do
    {:ok, page} = Cache.lookup("/")

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
    {:ok, page} = Cache.lookup("@404")

    conn
    |> put_html_content_type()
    |> send_resp(
      404,
      page
    )
  end

  @spec put_html_content_type(Plug.Conn.t()) :: Plug.Conn.t()
  defp put_html_content_type(conn) do
    put_resp_content_type(conn, "text/html; charset=utf-8")
  end

  @spec redirect(Plug.Conn.t(), binary) :: Plug.Conn.t()
  defp redirect(conn, dest) do
    conn
    |> put_resp_header("Location", dest)
    |> send_resp(302, "")
  end

  @spec precache :: nil
  def precache do
    to_cache = [
      {
        "/",
        EEx.eval_file("site/index.html.eex",
          canonical_url: Helpers.get_canonical_url("/"),
          generate_head_tags: &Helpers.generate_head_tags/3
        )
      },
      {
        "@404",
        EEx.eval_file("site/404.html.eex",
          generate_head_tags: &Helpers.generate_head_tags/1
        )
      }
    ]

    for {location, content} <- to_cache do
      Logger.debug("Pre-caching #{location} ...")
      Cache.insert(location, content)
    end

    nil
  end

  def start_link do
    {:ok, _} = Plug.Cowboy.http(WwwArjunsatarkarNet.Router, [])
  end
end
