#!/usr/bin/env bash
set -e

RABBITMQ_PIDFILE=/var/lib/rabbitmq/mnesia/$RABBITMQ_NODENAME.pid

function bootstrap {
  #Not especially proud of this, but it works (unlike the environment variable approach in the docs)
  rabbitmqctl wait ${RABBITMQ_PIDFILE} -t 500

  rabbitmqctl add_user {{ .Values.users.default.user }} {{ .Values.users.default.password | default (tuple . .Values.users.default.user | include "rabbitmq.password_for_user") | quote }} || true
  rabbitmqctl set_permissions {{ .Values.users.default.user }} ".*" ".*" ".*" || true

  rabbitmqctl add_user {{ .Values.users.admin.user }} {{  .Values.users.admin.password | default (tuple . .Values.users.admin.user | include "rabbitmq.password_for_user") | quote }} || true
  rabbitmqctl set_permissions {{ .Values.users.admin.user }} ".*" ".*" ".*" || true
  rabbitmqctl set_user_tags {{ .Values.users.admin.user }} administrator || true

  {{- if .Values.metrics.enabled }}
  rabbitmqctl add_user {{ .Values.metrics.user }} {{  .Values.metrics.password | default (tuple . .Values.metrics.user | include "rabbitmq.password_for_user") | quote }} || true
  rabbitmqctl set_permissions {{ .Values.metrics.user }} ".*" ".*" ".*" || true
  rabbitmqctl set_user_tags {{ .Values.metrics.user }} monitoring || true
  {{- end }}

  rabbitmqctl change_password guest {{ .Values.users.default.password | default (tuple . .Values.users.default.user | include "rabbitmq.password_for_user") | quote }} || true
  rabbitmqctl set_user_tags guest monitoring || true
}


function start_application {
  echo "Starting RabbitMQ with lock /var/lib/rabbitmq/rabbitmq-server.lock"
  LOCKFILE=/var/lib/rabbitmq/rabbitmq-server.lock

  if [ "${RABBITMQ_ERLANG_COOKIE:-}" ]; then
  cookieFile='/var/lib/rabbitmq/.erlang.cookie'
  echo "$RABBITMQ_ERLANG_COOKIE" > "$cookieFile"
  fi
  chmod 600 "$cookieFile"
  chown -R rabbitmq:rabbitmq /var/lib/rabbitmq


  exec 9>${LOCKFILE}
  /usr/bin/flock -n 9
  bootstrap &
  exec gosu rabbitmq rabbitmq-server
}

start_application
