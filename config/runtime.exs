import Config

config :www_arjunsatarkar_net,
  port: String.to_integer(System.get_env("PORT", "8000")),
  template_file_names: ["site/index.html.eex", "site/404.html.eex"]
