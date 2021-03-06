#!/bin/sh
set -e

function require_env() {
    if [ "$#" -ne 1 ] || [ -z "$1" ]; then
        echo "require_env requires 1 argument" >&2
        exit 1
    fi
    NAME="$1"
    VALUE=$(printenv "${NAME}") || true
    if [ -z "${VALUE}" ]; then
        echo "ERROR: Environment variable ${NAME} is required but not set" >&2
        exit 1
    fi
}

require_env DOMAIN
SCHEDULE="${SCHEDULE:-0 0 * * *}"
export PATH=$PATH:/google-cloud-sdk/bin/

mkdir -p /acme

/issue.sh

/go-cron "${SCHEDULE}" /issue.sh
