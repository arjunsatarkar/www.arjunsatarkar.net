#!/usr/bin/env python3
import minify_html
import argparse

parser = argparse.ArgumentParser(description="Minify HTML in place.")
parser.add_argument("file")
args = parser.parse_args()

with open(args.file, "r") as file:
    result = minify_html.minify(
        file.read(),
        do_not_minify_doctype=True,
        ensure_spec_compliant_unquoted_attribute_values=True,
        keep_closing_tags=True,
        keep_html_and_head_opening_tags=True,
        keep_spaces_between_attributes=True,
    )

with open(args.file, "w") as file:
    file.write(result)
