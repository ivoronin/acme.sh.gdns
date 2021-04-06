#!/bin/sh
POSTHOOK=${POSTHOOK:-/bin/true}

acme.sh --issue --dns dns_gcloud -d ${DOMAIN} -k 4096 --reloadcmd "${POSTHOOK}" --home /acme

RENEW_SKIP=2
if [ $? -eq ${RENEW_SKIP} ]; then
    exit 0
fi
