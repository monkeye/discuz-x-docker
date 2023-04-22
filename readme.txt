docker build -t discuz:v2 -f Dockerfile . && docker run -d --name discuz -p 80:80 -it discuz:v2

docker run -it discuz:v2 /bin/bash

docker ps && docker images