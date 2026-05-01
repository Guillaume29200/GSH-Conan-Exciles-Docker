#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " GSH Conan Exiles Dedicated Server"
echo " Standardized Docker Image"
echo "=================================================="

# Lowercase aliases for GSH if needed
export GSH_TZ="${GSH_TZ:-${gsh_tz:-Europe/Paris}}"
export GSH_PUID="${GSH_PUID:-${gsh_puid:-1000}}"
export GSH_PGID="${GSH_PGID:-${gsh_pgid:-1000}}"

export GSH_STEAM_APP_ID="${GSH_STEAM_APP_ID:-${gsh_steam_app_id:-443030}}"
export GSH_STEAM_USER="${GSH_STEAM_USER:-${gsh_steam_user:-anonymous}}"
export GSH_STEAM_PASSWORD="${GSH_STEAM_PASSWORD:-${gsh_steam_password:-}}"
export GSH_GAME_UPDATE="${GSH_GAME_UPDATE:-${gsh_game_update:-true}}"
export GSH_VALIDATE_FILES="${GSH_VALIDATE_FILES:-${gsh_validate_files:-true}}"

export GSH_SERVER_NAME="${GSH_SERVER_NAME:-${gsh_server_name:-GSH Conan Exiles Server}}"
export GSH_SERVER_PASSWORD="${GSH_SERVER_PASSWORD:-${gsh_server_password:-}}"
export GSH_ADMIN_PASSWORD="${GSH_ADMIN_PASSWORD:-${gsh_admin_password:-changeme}}"
export GSH_MAX_PLAYERS="${GSH_MAX_PLAYERS:-${gsh_max_players:-40}}"

export GSH_GAME_PORT="${GSH_GAME_PORT:-${gsh_game_port:-7777}}"
export GSH_GAME_PORT_RAW="${GSH_GAME_PORT_RAW:-${gsh_game_port_raw:-7778}}"
export GSH_QUERY_PORT="${GSH_QUERY_PORT:-${gsh_query_port:-27015}}"
export GSH_RCON_PORT="${GSH_RCON_PORT:-${gsh_rcon_port:-25575}}"
export GSH_RCON_ENABLED="${GSH_RCON_ENABLED:-${gsh_rcon_enabled:-false}}"
export GSH_RCON_PASSWORD="${GSH_RCON_PASSWORD:-${gsh_rcon_password:-changeme}}"

export GSH_USE_WINE="${GSH_USE_WINE:-${gsh_use_wine:-true}}"
export GSH_WINEPREFIX="${GSH_WINEPREFIX:-${gsh_wineprefix:-/opt/wine/conan-exiles}}"
export GSH_WINEARCH="${GSH_WINEARCH:-${gsh_winearch:-win64}}"
export GSH_DISPLAY="${GSH_DISPLAY:-${gsh_display:-:99}}"
export GSH_XVFB_RESOLUTION="${GSH_XVFB_RESOLUTION:-${gsh_xvfb_resolution:-1024x768x16}}"

export GSH_SERVER_EXE="${GSH_SERVER_EXE:-${gsh_server_exe:-ConanSandboxServer.exe}}"
export GSH_START_ARGS="${GSH_START_ARGS:-${gsh_start_args:--log}}"

ln -snf "/usr/share/zoneinfo/${GSH_TZ}" /etc/localtime || true
echo "${GSH_TZ}" > /etc/timezone || true

if [ "$(id -u gsh)" != "${GSH_PUID}" ]; then
    usermod -u "${GSH_PUID}" gsh
fi

if [ "$(id -g gsh)" != "${GSH_PGID}" ]; then
    groupmod -g "${GSH_PGID}" gsh
fi

chown -R gsh:gsh /opt/steam /opt/games /opt/wine

if [ "${GSH_GAME_UPDATE}" = "true" ]; then
    gosu gsh /scripts/steam-update.sh
fi

gosu gsh /scripts/write-config.sh

exec gosu gsh /scripts/start-server.sh
