#!/usr/bin/env bash

printf "%s\n" "Creating new .env..."
if [[ ! -d ~/.env ]]; then
  python -m venv ~/.env
  printf "%s\n" "Creation of .env: SUCCESS."
else
  printf "%s\n" "Creation of .env: SKIPPED."
fi
