#!/usr/bin/env bash
set -euxo pipefail

mkdir -p sitebuild
cp -r sitesrc/static sitebuild/
cp sitesrc/404.html sitebuild/
asciidoctor -a webfonts! -a last-update-label! -a stylesheet=main.css -a stylesdir=/static/styles -a linkcss -a copycss! -a favicon=/static/media/favicon.svg -a docinfodir=docinfo --destination-dir=sitebuild/html sitesrc/asciidoc/*.adoc
