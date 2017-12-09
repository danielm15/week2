FROM node
WORKDIR /server
RUN apt-get update
RUN apt-get install telnet
COPY package.json .
RUN npm install --silent
CMD 'sudo usermod -a -G docker ec2-user'
COPY . .
EXPOSE 8080
ENV NODE_PATH /server/
CMD ["./runserver.sh"]
