#!/usr/bin/env bash
set -euxo pipefail

mkdir -p sitebuild

asciidoctor -a webfonts! -a last-update-label! -a stylesheet=main.css -a stylesdir=/static/styles -a linkcss -a copycss! -a favicon=/static/media/favicon.svg -a docinfodir=docinfo --destination-dir=sitebuild/ sitesrc/*.adoc

cp -r sitesrc/static sitebuild/
