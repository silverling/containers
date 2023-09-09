#!/bin/bash
set -e

DAEMON=sshd

stop() {
    echo "Received SIGINT or SIGTERM. Shutting down $DAEMON."
    local pid=$(cat /var/run/$DAEMON/$DAEMON.pid)
    kill -SIGTERM "${pid}"
    wait "${pid}"
    echo "Done."
}

echo "Starting $DAEMON."
trap stop SIGINT SIGTERM
service ssh start -D &
pid="$!"
mkdir -p /var/run/$DAEMON && echo "${pid}" > /var/run/$DAEMON/$DAEMON.pid
wait "${pid}"
exit $?
