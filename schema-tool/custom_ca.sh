#!/bin/sh

# SPDX-FileCopyrightText: 2025 Health-RI
# SPDX-FileCopyrightText: 2026 Molecular Medicine Center
#
# SPDX-License-Identifier: Apache-2.0

# Use first argument as CRT file, default to ./my-ca.crt
CRT_FILE="${1:-./my-ca.crt}"

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 [CRT_FILE]"
  echo "Mounts CRT_FILE into the container and imports it into a truststore (output/truststore.jks)."
  echo "Default CRT_FILE: ./my-ca.crt"
  exit 0
fi

if [ ! -f "$CRT_FILE" ]; then
  echo "Error: CRT file not found: $CRT_FILE" >&2
  exit 2
fi

# Derive alias from filename (basename without extension)
ALIAS=$(basename "$CRT_FILE")
ALIAS=${ALIAS%.*}

docker run --rm \
  -v "$CRT_FILE":/tmp/my-ca.crt:ro \
  -v "$PWD":/output \
  --entrypoint sh \
  healthri/fdp-schema-update-tool:1.0.4 \
  -c 'cp $JAVA_HOME/lib/security/cacerts /output/truststore.jks && \
    keytool -importcert -keystore /output/truststore.jks -storepass changeit -noprompt -alias '"$ALIAS"' -file /tmp/my-ca.crt'