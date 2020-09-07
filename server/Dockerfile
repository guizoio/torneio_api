FROM node:14.3.0-alpine3.11

WORKDIR /usr/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 4403

CMD ["npm","start"]