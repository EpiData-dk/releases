#!/bin/bash

# logging
fatal() { echo "$*" >&2; exit 1; }
error() { echo "$*" >&2; }
info()  { echo "$*" >&1; }
verbose() { [[ -z "${verbose:+x}" ]] || echo "$*" >&2; }
debug() { [[ -z "${debug:+x}" ]] || echo "$*" >&2; }
