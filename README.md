# homebox-brother-pt

A Docker image extending [Homebox](https://github.com/sysadminsmedia/homebox) with support for printing labels on Brother P-Touch network printers.

Tested on a **Brother P750W** with **18mm tape**.

## Prerequisites

> **Note:** This image requires structured label env vars introduced in [sysadminsmedia/homebox#1529](https://github.com/sysadminsmedia/homebox/pull/1529). Until that PR is merged, use the `:dev` image tag which is built against a fork with that patch applied.

## Usage

Replace your existing Homebox container image with this one:

```
ghcr.io/trevor159/homebox-brother-pt:dev
```

Once [#1529](https://github.com/sysadminsmedia/homebox/pull/1529) is merged, you can use the `:latest` or a versioned tag instead.

## Configuration

Set `HBOX_LABEL_MAKER_PRINT_COMMAND` in your Homebox environment to invoke the print script with your printer's parameters. The image sets a default value pointing to the script — you only need to override it to pass your printer-specific flags.

```
HBOX_LABEL_MAKER_PRINT_COMMAND=/usr/local/bin/print-label.sh --host <printer-ip> --model P750W --media W18
```

### Options

| Flag | Required | Default | Description |
|------|----------|---------|-------------|
| `--host` | Yes | — | Printer hostname or IP address |
| `--port` | No | `9100` | TCP port |
| `--model` | No | `P750W` | Printer model: `P700` or `P750W` |
| `--media` | No | `W18` | Tape width: `W3_5`, `W6`, `W9`, `W12`, `W18`, `W24` |

### Environment variables

These are set automatically by Homebox when a label is printed:

| Variable | Description |
|----------|-------------|
| `LABEL_URL` | URL to the item or location page (used as QR code target) |
| `LABEL_Name` | Item or location name |
| `LABEL_AssetID` | Asset ID (e.g. `000-001`) |

## Docker Compose example

```yaml
services:
  homebox:
    image: ghcr.io/trevor159/homebox-brother-pt:dev
    environment:
      HBOX_LABEL_MAKER_PRINT_COMMAND: >-
        /usr/local/bin/print-label.sh
        --host 192.168.1.50
        --model P750W
        --media W18
    volumes:
      - homebox-data:/data
    ports:
      - "7745:7745"

volumes:
  homebox-data:
```

## Image tags

| Tag | Description |
|-----|-------------|
| `:dev` | Built from a fork with [#1529](https://github.com/sysadminsmedia/homebox/pull/1529) — use this until the PR is merged |
| `:latest` | Tracks the latest stable Homebox release |
| `:vX.Y.Z` | Pinned to a specific Homebox release |
| `:nightly` | Built nightly from the Homebox nightly image |
