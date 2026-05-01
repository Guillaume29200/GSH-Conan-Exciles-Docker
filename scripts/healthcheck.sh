#!/usr/bin/env bash
set -euo pipefail

pgrep -f "ConanSandboxServer.exe|wine" >/dev/null 2>&1
