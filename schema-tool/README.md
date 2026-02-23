# Schema Tool

Scripts for running the FDP Schema Update Tool with optional custom CA trust.

## Configuration

Copy `.env.example` to `.env` and fill in:

```env
FDP_HOST=https://your-fdp-host.org
FDP_USER=user@example.org
FDP_PWD=your-password
PROPERTIES_LOCATION=./Properties.yaml
```

## Scripts

### `run.sh`

Runs the schema update tool against the configured FDP instance.

```sh
# Without custom CA
./run.sh

# With custom CA truststore
./run.sh truststore.jks
```

Reads credentials from `.env`. When a truststore is provided, it is mounted into the container and the JVM is configured to use it.

### `custom_ca.sh`

Generates a Java truststore (`truststore.jks`) containing the default JVM certificates plus a custom CA certificate.

```sh
# Using default file ./my-ca.crt
./custom_ca.sh

# Using a specific certificate file
./custom_ca.sh /path/to/my-ca.crt
```

The resulting `truststore.jks` is written to the current directory and can be passed to `run.sh`.

## Typical workflow

```sh
# 1. Generate truststore from your CA certificate
./custom_ca.sh my-ca.crt

# 2. Run the schema tool with the truststore
./run.sh truststore.jks
```
