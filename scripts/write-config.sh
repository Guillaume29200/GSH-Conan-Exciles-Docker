#!/usr/bin/env bash
set -euo pipefail

SERVER_DIR="/opt/games/server"
CONFIG_ROOT="/opt/games/config"

CONAN_CONFIG_DIR="${SERVER_DIR}/ConanSandbox/Saved/Config/WindowsServer"
ENGINE_INI="${CONAN_CONFIG_DIR}/Engine.ini"
SERVER_SETTINGS_INI="${CONAN_CONFIG_DIR}/ServerSettings.ini"

mkdir -p "${CONAN_CONFIG_DIR}"
mkdir -p "${CONFIG_ROOT}"

echo "--------------------------------------------------"
echo " Writing Conan Exiles config"
echo " ServerSettings: ${SERVER_SETTINGS_INI}"
echo " Engine: ${ENGINE_INI}"
echo "--------------------------------------------------"

cat > "${SERVER_SETTINGS_INI}" <<EOF
[ServerSettings]
ServerName=${GSH_SERVER_NAME}
ServerPassword=${GSH_SERVER_PASSWORD}
AdminPassword=${GSH_ADMIN_PASSWORD}
MaxPlayers=${GSH_MAX_PLAYERS}
DedicatedServerLauncher=False
EOF

cat > "${ENGINE_INI}" <<EOF
[URL]
Port=${GSH_GAME_PORT}

[OnlineSubsystemSteam]
GameServerQueryPort=${GSH_QUERY_PORT}

[OnlineSubsystem]
ServerPassword=${GSH_SERVER_PASSWORD}
EOF

if [ "${GSH_RCON_ENABLED}" = "true" ]; then
cat >> "${SERVER_SETTINGS_INI}" <<EOF

[RconPlugin]
RconEnabled=True
RconPassword=${GSH_RCON_PASSWORD}
RconPort=${GSH_RCON_PORT}
EOF
fi

# Keep a readable copy for GSH/debug outside the game tree
cp "${SERVER_SETTINGS_INI}" "${CONFIG_ROOT}/ServerSettings.ini"
cp "${ENGINE_INI}" "${CONFIG_ROOT}/Engine.ini"

echo "Config ready."
