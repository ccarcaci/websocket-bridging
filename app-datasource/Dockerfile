FROM node:14.15-alpine3.12 as compose-dependencies

WORKDIR app

COPY package.json .

RUN npm install

# ## ### ##### ########

FROM node:14.15-alpine3.12 as compose-run

WORKDIR /app

COPY src src
COPY --from=compose-dependencies /app/node_modules node_modules

RUN npm install --global nodemon

ENV PATH /app/node_modules/.bin:$PATH
