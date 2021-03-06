#!/bin/sh
set -e

[[ $DEBUG ]] && set -x

# Disabling nginx daemon mode
export KONG_NGINX_DAEMON="off"

# Setting default prefix (override any existing variable)
export KONG_PREFIX="/usr/local/kong"

# Prepare Kong prefix
if [ ! -f /data/.inited ]; then
	kong prepare -p "/usr/local/kong" \
	&& kong migrations up \
	&& touch /data/.inited
fi

sleep ${PAUSE:-0}

exec "$@"