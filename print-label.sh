#!/bin/sh
# Prints a label on a Brother P-Touch printer via labelprinterkit.
#
# Usage: print-label.sh [OPTIONS]
#
# Options:
#   --host HOST      Printer hostname or IP (required)
#   --port PORT      TCP port (default: 9100)
#   --model MODEL    Printer model: P700 or P750W (default: P750W)
#   --media MEDIA    Tape width: W3_5 W6 W9 W12 W18 W24 (default: W18)
#
# Example HBOX_LABEL_MAKER_PRINT_COMMAND:
#   /usr/local/bin/print-label.sh --host 192.168.1.50 --model P750W --media W18
#
# Env vars set automatically by Homebox:
#   LABEL_URL         — URL to the item or location page
#   LABEL_Name        — item or location name
#   LABEL_AssetID     — asset ID (e.g. 000-001)

exec python3 /usr/local/bin/print-label.py "$@"
