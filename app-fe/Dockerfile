FROM node:14.15-alpine3.12 AS base-build

WORKDIR /app

COPY public public
COPY package.json .
COPY tsconfig.json .

RUN npm install
RUN ln -s /app/node_modules/typescript/bin/tsc /usr/local/bin/typescript \
  && ln -s /app/node_modules/react-scripts/bin/react-scripts.js /usr/local/bin/react-scripts \
  && ln -s /app/node_modules/env-cmd/bin/env-cmd.js /usr/local/bin/env-cmd

# ## ### ##### ########

FROM base-build AS compose-run

COPY .env.docker .env

# ## ### ##### ########

FROM base-build AS prod-build

COPY .eslintignore .
COPY src src

RUN react-scripts build

# ## ### ##### ########

FROM nginx:stable-alpine

COPY --from=prod-build /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]

# docker run --name ws-bridge-fe:prod --publish 8080:80 ws-bridge/fe:prod > /dev/null &
