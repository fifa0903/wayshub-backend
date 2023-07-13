FROM node:14.21.3-alpine
WORKDIR /app

COPY . .
RUN npm install

RUN npm install sequelize-cli -g

#ENV DB_HOST=wayshub-db
#//ENV DB_USERNAME=mahesa
#//ENV DB_PASSWORD=mahesa123

RUN sequelize db:create

COPY migrations /migrations
RUN sequelize db:migrate

EXPOSE 5000
CMD [ "npm", "start" ]





