# GSH Conan Exiles Docker - Standardized

Docker image for Conan Exiles Dedicated Server, optimized for GameServer-Hub (GSH).

## Standard GSH paths

```txt
/opt/steam           -> SteamCMD persistent directory
/opt/games/server    -> Game server files
/opt/games/config    -> External readable config copy
/opt/wine            -> Wine prefix storage
```

## Volumes

```yaml
volumes:
  - ./data/server:/opt/games/server
  - ./data/config:/opt/games/config
  - ./data/wine:/opt/wine
  - ./data/steam:/opt/steam
```

## Build

```bash
docker build -t slymer29/gsh-conan-exiles:latest .
```

## Push

```bash
docker push slymer29/gsh-conan-exiles:latest
```

## Run

```bash
docker compose up -d
```

## AppID

```env
GSH_STEAM_APP_ID=443030
```
