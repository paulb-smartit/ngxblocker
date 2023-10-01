#!/bin/bash

_AUTHOR="Paul Bargewell <paul.bargewell@smart-ltd.co.uk>"
_COPYRIGHT="Copyright 2023, Smart IT Limited"
_LICENSE="SPDX-License-Identifier: AGPL-3.0-or-later"
_ Prefix to prevent shellcheck error SC2034

WGET=$(which wget)
if [[ -z "${WGET}" ]]; then
    apt-get update
    apt-get install -y wget
    apt-get clean
    rm -rf /var/lib/apt/lists/*
fi

SRC=https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/
BOTS="blockbots.conf ddos.conf whitelist-ips.conf whitelist-domains.conf \
    blacklist-user-agents.conf custom-bad-referrers.conf blacklist-ips.conf bad-referrer-words.conf"
CONFS="globalblacklist.conf botblocker-nginx-settings.conf"

if [[ ! -d "/etc/nginx/bots.d" ]]; then
    mkdir /etc/nginx/bots.d
fi

for BOT in ${BOTS}; do
    if [[ ! -f "/etc/nginx/bots.d/${BOT}" ]]; then
        curl -sL "${SRC}/bots.d/${BOT}" -o "/etc/nginx/bots.d/${BOT}"
    fi
done

for CONF in ${CONFS}; do
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/${CONF} -o /etc/nginx/conf.d/${CONF}
done

chown www-data: /etc/nginx/bots.d/* /etc/nginx/conf.d/* -Rv
