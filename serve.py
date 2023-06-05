#!/usr/bin/env python3
import gevent.monkey

gevent.monkey.patch_all()

import argparse
import pathlib
import bottle


def port(port_str: str) -> int:
    port = int(port_str)
    if port <= 0:
        raise ValueError("port must be positive")
    elif port > 65535:
        raise ValueError("port must be 65535 or below")
    return port


parser = argparse.ArgumentParser(prog="www.arjunsatarkar.net server")
parser.add_argument("--host", default="127.0.0.1")
parser.add_argument("--port", default=9001, type=port)
args = parser.parse_args()

SITE_ROOT = pathlib.Path("sitebuild")


@bottle.route("/")
def index():
    return bottle.static_file("index.html", SITE_ROOT / "html")


@bottle.route("/static/<static_file_path:path>")
def static(static_file_path):
    mimetype = "auto"
    # Bottle by default uses application/javascript which is no longer standard https://2ality.com/2022/05/rfc-9239.html
    # This also causes non-inclusion of charset, which is problematic. Hence, we override.
    if static_file_path.endswith(".js"):
        mimetype = "text/javascript; charset=utf-8"
    return bottle.static_file(static_file_path, SITE_ROOT / "static", mimetype)


@bottle.route("/favicon.ico")
def root_favicon():
    return bottle.redirect("/static/media/favicon.ico")


@bottle.error(404)
def error404(_):
    response = bottle.static_file("404.html", SITE_ROOT / "html")
    response.status = 404
    return response


if __name__ == "__main__":
    bottle.run(host=args.host, port=args.port, server="gevent", debug=False)
