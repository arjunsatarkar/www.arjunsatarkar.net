#!/usr/bin/env bash
set -euxo pipefail

BASEDIR="$PWD"

mkdir -p sitebuild

asciidoctor -a webfonts! -a last-update-label! -a stylesheet=main.css -a stylesdir=/static/styles -a linkcss -a copycss! -a favicon=/static/media/favicon.svg -a docinfodir=docinfo --destination-dir=sitebuild/html sitesrc/asciidoc/*.adoc

cp -r sitesrc/static sitebuild/

{
    cd "$BASEDIR/sitebuild/static/scripts/" &&
    for f in *.js; do
        npx terser "$f" -o "$f"
    done
} || true

{
    cd "$BASEDIR/sitebuild/static/styles/" &&
    for f in *.css; do
        npx postcss "$f" --replace
    done
} || true

{
    cd "$BASEDIR/sitebuild/html" &&
    for f in *.html; do
        "$BASEDIR/html_minify.py" "$f"
    done
} || true

cd "$BASEDIR"
