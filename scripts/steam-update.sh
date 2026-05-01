#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/opt/games/server"

echo "--------------------------------------------------"
echo " SteamCMD update/install"
echo " Game: Conan Exiles"
echo " AppID: ${GSH_STEAM_APP_ID}"
echo " Install dir: ${INSTALL_DIR}"
echo " Steam dir: /opt/steam"
echo "--------------------------------------------------"

VALIDATE_ARG=""
if [ "${GSH_VALIDATE_FILES}" = "true" ]; then
    VALIDATE_ARG="validate"
fi

if [ "${GSH_STEAM_USER}" = "anonymous" ]; then
    /opt/steam/steamcmd.sh \
        +force_install_dir "${INSTALL_DIR}" \
        +login anonymous \
        +app_update "${GSH_STEAM_APP_ID}" ${VALIDATE_ARG} \
        +quit
else
    /opt/steam/steamcmd.sh \
        +force_install_dir "${INSTALL_DIR}" \
        +login "${GSH_STEAM_USER}" "${GSH_STEAM_PASSWORD}" \
        +app_update "${GSH_STEAM_APP_ID}" ${VALIDATE_ARG} \
        +quit
fi
