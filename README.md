# www.arjunsatarkar.net

See [the live site](https://www.arjunsatarkar.net/).

## Notice

<span>www</span>.<span>arjunsatarkar</span>.<span>net</span> is copyright © 2023-present Arjun Satarkar.

It is intended specifically and only to run https://www.arjunsatarkar.net, and is not useful as a generic static site
generator or CMS.

## Usage

Prerequisites:
- [Elixir](https://elixir-lang.org/)

Provide the `PORT` environment variable at runtime to set a port (default 8000).

Build with environment variable `PROXIED=1` to use the `X-Forwarded-Host`, `X-Forwarded-Port`, and `X-Forwarded-Proto`
headers. Ensure that the reverse proxy actually sets these.

If changing the value of `PROXIED`, run `mix deps.clean www_arjunsatarkar_net --build` first.

Interactive:
```
iex -S mix
```

Development:
```
mix run
```

Release:
```
MIX_ENV=prod mix release
_build/prod/rel/www_arjunsatarkar_net/bin/www_arjunsatarkar_net start
```
