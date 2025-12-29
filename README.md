<!--
SPDX-FileCopyrightText: 2024 Health-RI.

SPDX-License-Identifier: CC-BY-4.0
-->

# Updating SHACLs with the schema tool

Use the schema tool to push the SHACL updates to your FDP instance.

1. Open `schema-tool/.env`.
2. Set `FDP_HOST` to the FDP you want to update.
3. Set `FDP_USER` and `FDP_PWD` to credentials for a user with admin rights on that FDP.
4. From `schema-tool/`, run `docker compose up` (or `docker-compose up`) to apply the updates.

## Repository contents

- `Formulasation(shacl)/core/PiecesShape`: SHACL shapes for the harmonised GDI metadata model (e.g., Dataset, Catalog, Distribution, DataService, Identifier).
- `schema-tool/Properties.yaml`: Defines how the individual shapes are combined, parent/child relations, and which shapes are published to the FDP.
- `schema-tool/docker-compose.yml` and `.env`: Wrapper to run the schema update tool container against a target FDP with your credentials.
- `CHANGELOG.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`: Standard project documentation and contribution guidelines.

Current SHACLs are based on:
- GDI harmonised metadata spreadsheet: https://docs.google.com/spreadsheets/d/1XsXdBD6jD8f6nUaUSB4pHGtqynJUkoZ9PQXpxWNZ4qw/edit?gid=225294581#gid=225294581
- HealthDCAT-AP 5.0: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-5/
