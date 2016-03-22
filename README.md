# Factorio headless server in Docker

## Run it yourself on Linux
Use "saves" directory in current path for save file storage. Exposes the default Factorio port on your local Linux machine.

    docker run -it \
           -p "34197:34197/udp" \
           -v "$PWD/saves:/opt/factorio/saves" \
           stanislavb/factorio-server
