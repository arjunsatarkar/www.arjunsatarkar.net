#!/usr/bin/env python3
import gevent.os, gevent.subprocess
import gevent.monkey

gevent.monkey.patch_all()

import pathlib
import bottle

DEBUG = False
HOST = "127.0.0.1"
PORT = 9001
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
    bottle.run(host=HOST, port=PORT, server="gevent", debug=DEBUG)
