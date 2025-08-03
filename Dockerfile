FROM node:lts-slim AS build
WORKDIR /src
RUN npm install -g @angular/cli

COPY package*.json ./
RUN npm ci

COPY . ./
RUN ng build

FROM nginx:stable AS final
EXPOSE 80
COPY --from=build src/dist/helloworld/browser  /usr/share/nginx/html
