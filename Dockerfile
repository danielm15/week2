FROM node
WORKDIR /server
RUN apt-get update
RUN apt-get install telnet
RUN apt-get install sudo
COPY package.json .
COPY . .
RUN npm install --silent

# Installing Docker
RUN wget https://get.docker.com/builds/Linux/x86_64/docker-1.11.0.tgz -O docker.tgz  
RUN tar -xvzf docker.tgz  
RUN mv docker/* /usr/bin/  
RUN chmod +x /usr/bin/docker

# Installs Docker Compose
RUN curl --fail --silent -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose  
RUN chmod +x /usr/bin/docker-compose 

EXPOSE 8080
ENV NODE_PATH /server/
CMD ["./runserver.sh"]
