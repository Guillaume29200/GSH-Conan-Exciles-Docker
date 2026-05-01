#!/usr/bin/env bash
set -euo pipefail

SERVER_DIR="/opt/games/server"
EXE_PATH="${SERVER_DIR}/ConanSandbox/Binaries/Win64/${GSH_SERVER_EXE}"

export WINEPREFIX="${GSH_WINEPREFIX}"
export WINEARCH="${GSH_WINEARCH}"
export DISPLAY="${GSH_DISPLAY}"

echo "--------------------------------------------------"
echo " Starting Conan Exiles Dedicated Server"
echo " Server dir: ${SERVER_DIR}"
echo " Exe: ${EXE_PATH}"
echo " Wine prefix: ${WINEPREFIX}"
echo " Display: ${DISPLAY}"
echo "--------------------------------------------------"

mkdir -p "${WINEPREFIX}"

wineboot --init || true

Xvfb "${DISPLAY}" -screen 0 "${GSH_XVFB_RESOLUTION}" &
XVFB_PID=$!

cleanup() {
    echo "Stopping Conan Exiles..."
    kill "${XVFB_PID}" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

if [ ! -f "${EXE_PATH}" ]; then
    echo "ERROR: Cannot find ${EXE_PATH}"
    echo "Steam update may have failed or Conan server structure changed."
    find "${SERVER_DIR}" -maxdepth 5 -type f -iname "*.exe" | sort || true
    exit 1
fi

cd "$(dirname "${EXE_PATH}")"

exec wine "${EXE_PATH}" ${GSH_START_ARGS}
