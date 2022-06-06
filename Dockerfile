FROM node:18.3.0 as base

RUN mkdir /home/node/app
RUN chown -R node:node /home/node/app

USER node
WORKDIR /home/node/app

# Copy dependency information and install all dependencies
COPY --chown=node:node ./app/package.json ./app/package-lock.json ./
RUN npm ci

# Copy app and build app
COPY --chown=node:node ./app ./
RUN npm run lint
RUN npm run build


FROM node:18.2.0-alpine3.15 as prod

RUN apk add --no-cache bash

RUN mkdir /home/node/app
RUN chown -R node:node /home/node/app

USER node
WORKDIR /home/node/app

ENV NODE_ENV=production

# Copy dependency information and install production-only dependencies
COPY --chown=node:node --from=base ./home/node/app/package-lock.json ./home/node/app/package.json ./
RUN npm ci --production

# Copy build results from previous stage
COPY --chown=node:node --from=base ./home/node/app/build/dist ./build/dist

# Copy app
COPY --chown=node:node ./app ./


FROM node:18.2.0-alpine3.15 as dev

RUN apk add --no-cache bash

RUN mkdir -p /var/app
RUN chown -R node:node /var/app

USER node
WORKDIR /var/app

ENV NODE_ENV=development

RUN echo "alias ll='ls -l'" >> ~/.bashrc
RUN echo "alias la='ls -la'" >> ~/.bashrc
