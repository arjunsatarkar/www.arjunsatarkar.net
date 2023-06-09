#!/usr/bin/env bash
set -euxo pipefail

BASEDIR="$PWD"

mkdir -p sitebuild

asciidoctor -a webfonts! -a last-update-label! -a stylesheet=main.css -a stylesdir=/static/styles -a linkcss -a copycss! -a favicon=/static/media/favicon.svg -a docinfodir=docinfo --destination-dir=sitebuild/html sitesrc/asciidoc/*.adoc

basic_build_static () {
    cp -r sitesrc/static sitebuild/
}

basic_build_static

{
    cd sitesrc/static/scripts/ &&
    for f in *.js; do
        npx terser "$f" > "$BASEDIR/sitebuild/static/scripts/$f"
    done &&
    cd "$BASEDIR/sitesrc/static/styles/" &&
    for f in *.css; do
        npx postcss "$f" > "$BASEDIR/sitebuild/static/styles/$f"
    done &&
    cd "$BASEDIR"
} || {
    >&2 echo "WARN: minify step failed; proceeding without minification."
    cd "$BASEDIR" &&
    basic_build_static
}
