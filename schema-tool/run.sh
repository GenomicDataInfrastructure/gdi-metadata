#!/bin/sh

# SPDX-FileCopyrightText: 2026 Molecular Medicine Center
# 
# SPDX-License-Identifier: Apache-2.0

# Usage: ./run.sh [truststore.jks]
# Runs the schema tool with optional custom truststore for CA trust.

set -e

# Source .env file
if [ -f .env ]; then
  . ./.env
fi

TRUSTSTORE="${1:-}"

DOCKER_ARGS="--rm --network host"
DOCKER_ARGS="$DOCKER_ARGS -v ${PROPERTIES_LOCATION}:/opt/app/Properties.yaml:ro"

if [ -n "$TRUSTSTORE" ]; then
  if [ ! -f "$TRUSTSTORE" ]; then
    echo "Error: truststore not found: $TRUSTSTORE" >&2
    exit 2
  fi
  DOCKER_ARGS="$DOCKER_ARGS -v $(cd "$(dirname "$TRUSTSTORE")" && pwd)/$(basename "$TRUSTSTORE"):/opt/app/truststore.jks:ro"
  DOCKER_ARGS="$DOCKER_ARGS -e JAVA_TOOL_OPTIONS='-Djavax.net.ssl.trustStore=/opt/app/truststore.jks -Djavax.net.ssl.trustStorePassword=changeit'"
fi

eval docker run $DOCKER_ARGS \
  healthri/fdp-schema-update-tool:1.0.4 \
  -h "$FDP_HOST" -u "$FDP_USER" -p "$FDP_PWD"
