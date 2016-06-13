# Create image by: docker build -t carlochess/arm7-minecraft .
# Run: docker run -d -p 25565:25565 --name mc  carlochess/arm7-minecraft
FROM oysteinjakobsen/armv7-oracle-java8
MAINTAINER Carlos Roman <carlochess@gmail.com>

# Download Minecraft Server components
RUN wget --no-check-certificate -q https://s3.amazonaws.com/Minecraft.Download/versions/1.9.2/minecraft_server.1.9.2.jar -O /minecraft_server.jar
#COPY minecraft_server.1.9.2.jar /minecraft_server.jar

# Sets working directory for the CMD instruction (also works for RUN, ENTRYPOINT commands)
# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /data

COPY server.properties /data/server.properties
RUN echo "[]" whitelist.json
RUN echo "[]" ops.json
RUN echo "[]" banned-ips.json
RUN echo "[]" banned-players.json

EXPOSE 25565
CMD echo eula=true > /data/eula.txt && java -jar /minecraft_server.jar
