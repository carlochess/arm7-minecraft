# Minecraft for Nvidia Jetson TK1: arm7-minecraft

This docker image provides a Minecraft Server version 1.9.2

To simply use the latest stable version, run

    docker run -d -p 25565:25565 --name mc carlochess/arm7-minecraft

where the standard server port, 25565, will be exposed on your host machine.

If you want to serve up multiple Minecraft servers or just use an alternate port,
change the host-side port mapping such as

    docker run -p 25566:25565 ...

will serve your Minecraft server on your host's port 25566 since the `-p` syntax is
`host-port`:`container-port`.

Speaking of multiple servers, it's handy to give your containers explicit names using `--name`, such as

    docker run -d -p 25565:25565 --name mc carlochess/arm7-minecraft

With that you can easily view the logs, stop, or re-start the container:

    docker logs -f mc
        ( Ctrl-C to exit logs action )

    docker stop mc

    docker start mc

## Interacting with the server

In order to attach and interact with the Minecraft server, add `-it` when starting the container, such as

    docker -it exec mc /bin/bash

With that you can attach and interact at any time using

    docker attach mc

and then Control-p Control-q to **detach**.

For remote access, configure your Docker daemon to use a `tcp` socket (such as `-H tcp://0.0.0.0:2375`)
and attach from another machine:

    docker -H $HOST:2375 attach mc

Unless you're on a home/private LAN, you should [enable TLS access](https://docs.docker.com/articles/https/).

If you add mods while the container is running, you'll need to restart it to pick those
up:

    docker stop mc
    docker start mc

# Creating your own image:

Download my dockerfile and use:

    docker build -t carlochess/arm7-minecraft .

## Using Docker Compose

Rather than type the server options below, the port mappings above, etc
every time you want to create new Minecraft server, you can now use
[Docker Compose](https://docs.docker.com/compose/). Start with a
`docker-compose.yml` file like the following:

```
version: '2'
services:
    minecraft-server:
      ports:
        - "25565"

      image: carlochess/arm7-minecraft

      container_name: mc

#      tty: true
#      stdin_open: true
      restart: always
```

and in the same directory as that file run

    docker-compose -d up
or if you want more servers 
    docker-compose scale minecraft-server=4

Now, go play...
