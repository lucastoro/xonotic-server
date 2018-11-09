# A Xonotic server docker container with map provisioning via http.

## Building
Build the container with
`docker build -t xonotic-server ./docker`
(the `build` script can be used to ease this process).

## Running
Run the container with
`docker run --rm -it -p 26000:80/tcp -p 26000:26000/udp -v $PWD:/opt/Xonotic/shared xonotic-server`
(the `run` script can be used to ease this process).

Inside the $PWD (or whatever) mounted directory you need to put your `server.cfg` file and eventually a `maps` subdirectory containing the maps you want to provide to the clients.

Inside the mounted directory you'll find the Xonotic server log file and the http server errors log file.

## De HTTP server
The HTTP web server will listen on the 26000 TCP port (to mimic the UDP one used by the game itself) and serves the map files directly from the mounted volume, so you can easily add an index.html file inside that directory to provide a welcome page or stuff like that.

## About the Xonotic archive
The Dockerfile file can be configured to automatically download the latest Xonotic package from the web or to use a local .zip file. Inside the Dockerfile you'll see a couple of lines like:
```
 #RUN curl --output xonotic-latest.zip $(cu...
COPY xonotic-0.8.2.zip /opt/xonotic-latest.zip
```
If you decide to let docker to download the archive automagically you shall uncomment the `RUN` instruction and comment the `COPY` one.
If instead you want to use an archive you manually downloaded you shall comment the `RUN` instruction, uncomment the `COPY` one, change the source filename (i.e. xonotic-0.8.2.zip) accordingly and of course put the archive inside the docker directory before issuing the `docker build` or `./build` command.

## About the Xonotic server.cfg
If the 'map provisioning' feature is required the server.cfg file must contain the sv\_curl\_defaulturl entry set to the visible hostname in the following format:
`sv_curl_defaulturl http://mighty-xonotic-server:26000/maps/`
