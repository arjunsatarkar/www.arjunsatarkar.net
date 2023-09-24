import Config

config :www_arjunsatarkar_net,
  port: String.to_integer(System.get_env("PORT", "8000"))
