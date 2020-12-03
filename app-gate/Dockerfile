FROM node:14.15-alpine3.12 as compose-dependencies

WORKDIR app

COPY package.json .

RUN npm install

# ## ### ##### ########

FROM node:14.15-alpine3.12 as compose-run

WORKDIR app

COPY src src
COPY --from=compose-dependencies /app/node_modules node_modules

RUN npm install --global nodemon

ENV PATH /app/node_modules/.bin:$PATH

# ## ### ##### ########

FROM node:14.15-alpine3.12 AS prod-dependencies

WORKDIR /app

COPY package.json .
COPY --from=compose-dependencies /app/package-lock.json .

RUN npm ci --production && npm cache clean --force

# ## ### ##### ########

FROM node:14.15-alpine3.12 AS prod-build

WORKDIR /app

COPY src src
COPY package.json .
COPY tsconfig.json .
COPY --from=prod-dependencies /app/node_modules node_modules

RUN npm install --global typescript
RUN npm run build

# ## ### ##### ########

FROM node:14.15-alpine3.12 AS prod-run

WORKDIR /app

COPY --from=prod-dependencies /app/node_modules node_modules
COPY --from=prod-build /app/build build

CMD [ "node", "build/index.js" ]

# docker run --name we-bridge-gate:prod --publish 4080:4000 ws-bridge/gate:prod > /dev/null &
