#!/usr/bin/env bash

set -euo pipefail

ARSNOVA_EP="${ARSNOVA_EP:=http://127.0.0.1:8080}"

# Check main landing page /mobile/
E_MOBILE=$(curl -sf --max-time 5 "${ARSNOVA_EP}/mobile/" | grep "<title>ARSnova")
[                     $? ] || exit 1

# Check /api/
E_API=$(curl -sf --max-time 5 "${ARSNOVA_EP}/api/motd/" | grep "\\[")
[                     $? ] || exit 1

# Check /customization/account.html
E_CUSTOM=$(curl -sf --max-time 5 "${ARSNOVA_EP}/customization/account.html" | grep "ARSnova")
[                     $? ] || exit 1

