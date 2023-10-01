import Config

config :www_arjunsatarkar_net,
  canonical_host: "www.arjunsatarkar.net",
  canonical_port: 443,
  canonical_scheme: "https",
  templates_to_compile: [],
  port: String.to_integer(System.get_env("PORT", "8000"))
