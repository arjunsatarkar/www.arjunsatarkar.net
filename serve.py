#!/usr/bin/env python3
import gevent.monkey

gevent.monkey.patch_all()

import argparse
import pathlib
import bottle


def parse_port(port_str: str):
    port = int(port_str)
    if port <= 0:
        raise ValueError(f"port must be positive")
    return port

parser = argparse.ArgumentParser(prog="www.arjunsatarkar.net server")
parser.add_argument("--host", default="127.0.0.1")
parser.add_argument("--port", default=9001, type=parse_port)
args = parser.parse_args()

SITE_ROOT = pathlib.Path("sitebuild")


@bottle.route("/")
def index():
    return bottle.static_file("index.html", SITE_ROOT / "html")


@bottle.route("/static/<static_file_path:path>")
def static(static_file_path):
    return bottle.static_file(static_file_path, SITE_ROOT / "static")


@bottle.error(404)
def error404(error):
    response = bottle.static_file("404.html", SITE_ROOT)
    response.status = 404
    return response


if __name__ == "__main__":
    bottle.run(host=args.host, port=args.port, server="gevent", debug=False)
