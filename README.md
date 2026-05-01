# VERSION ALPHA !!! NE PAS UTILISE

# 🐳 Conan Exiles Dedicated Server - GSH Standard

## 📌 Description

Image Docker dédiée au serveur Conan Exiles, entièrement standardisée pour l’écosystème GameServer-Hub (GSH).

Cette image permet de déployer facilement un serveur Conan Exiles sous Linux via Wine + SteamCMD, avec gestion automatique de l'installation, des mises à jour et de la configuration.

---

## 🚀 Features

- Installation automatique via SteamCMD
- Support Wine + Xvfb (serveur Windows sous Linux)
- Mise à jour automatique du serveur
- Configuration dynamique via variables GSH
- Structure standardisée pour tous les jeux GSH
- Compatible Docker, VPS et serveur dédié

---

## 📁 Structure GSH

```txt
/opt/steam            -> SteamCMD (persistant)
/opt/games/server     -> Fichiers du serveur
/opt/games/config     -> Configuration externe lisible
/opt/wine             -> Environnement Wine
```

---

## ⚙️ Variables d’environnement (GSH)

### 🔧 Général

```env
GSH_TZ=Europe/Paris
GSH_PUID=1000
GSH_PGID=1000
```

---

### 📦 Steam

```env
GSH_STEAM_APP_ID=443030
GSH_STEAM_USER=anonymous
GSH_STEAM_PASSWORD=

GSH_GAME_UPDATE=true
GSH_VALIDATE_FILES=true
```

---

### 🎮 Serveur Conan Exiles

```env
GSH_SERVER_NAME=GSH Conan Exiles Server
GSH_SERVER_PASSWORD=
GSH_ADMIN_PASSWORD=changeme
GSH_MAX_PLAYERS=40
```

---

### 🌐 Réseau

```env
GSH_GAME_PORT=7777
GSH_GAME_PORT_RAW=7778
GSH_QUERY_PORT=27015

GSH_RCON_ENABLED=false
GSH_RCON_PORT=25575
GSH_RCON_PASSWORD=changeme
```

---

### 🧠 Wine / Display

```env
GSH_USE_WINE=true
GSH_WINEPREFIX=/opt/wine/conan-exiles
GSH_WINEARCH=win64
GSH_DISPLAY=:99
GSH_XVFB_RESOLUTION=1024x768x16
```

---

### ⚙️ Exécution

```env
GSH_SERVER_EXE=ConanSandboxServer.exe
GSH_START_ARGS=-log
```

---

## 🔌 Ports

- `7777/udp` → Game Port
- `7778/udp` → Raw Port
- `27015/udp` → Query Port
- `25575/tcp` → RCON (optionnel)

---

## 💾 Volumes

```yaml
volumes:
  - ./data/server:/opt/games/server
  - ./data/config:/opt/games/config
  - ./data/wine:/opt/wine
  - ./data/steam:/opt/steam
```

---

## ▶️ Exemple docker-compose

```yaml
version: "3.8"

services:
  conan:
    image: slymer29/gsh-conan-exiles:latest
    container_name: gsh-conan-exiles
    restart: unless-stopped

    ports:
      - "7777:7777/udp"
      - "7778:7778/udp"
      - "27015:27015/udp"
      - "25575:25575/tcp"

    environment:
      GSH_SERVER_NAME: "Mon serveur Conan"
      GSH_ADMIN_PASSWORD: "changeme"
      GSH_MAX_PLAYERS: 40

    volumes:
      - ./data/server:/opt/games/server
      - ./data/config:/opt/games/config
      - ./data/wine:/opt/wine
      - ./data/steam:/opt/steam
```

---

## ⚠️ Important

- Conan Exiles Dedicated Server est une application Windows exécutée via Wine
- Le premier démarrage peut être long (téléchargement SteamCMD)
- L’image ne contient pas les fichiers du jeu
- Les fichiers sont téléchargés automatiquement au premier lancement

---

## 🎯 Intégration GameServer-Hub

Cette image suit le standard GSH :

- Variables unifiées (`GSH_*`)
- Structure identique pour tous les jeux
- Déploiement automatisé
- Gestion centralisée via panel

---

## 🔥 Auteur

Image maintenue par **slymer29**

Optimisée pour l’écosystème **GameServer-Hub (GSH)**
