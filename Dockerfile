FROM alpine:latest
WORKDIR /src
EXPOSE 3000
RUN apk update && apk add nodejs npm
COPY package.json /src/package.json
RUN npm install
COPY . /src
CMD ["npm","start"]
