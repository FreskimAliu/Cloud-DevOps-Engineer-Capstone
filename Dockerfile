FROM node:17.6.0-slim

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

EXPOSE 8000

CMD [ "node", "server.js" ]
