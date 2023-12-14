#!/bin/sh

mkdir -p dist
jinja2 index.tpl data.yaml --format=yaml > dist/index.html
