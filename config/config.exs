import Config

config :www_arjunsatarkar_net,
  proxied: String.to_integer(System.get_env("PROXIED", "0")) != 0
