FROM elixir:1.10.2-alpine

RUN apk add --update nodejs nodejs-npm inotify-tools
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.4.16

RUN mkdir /app
WORKDIR /app

COPY source/ /app

RUN mix deps.get
RUN mix deps.compile 

RUN cd assets && \
    npm install && \
    node node_modules/webpack/bin/webpack.js --mode development
RUN mix compile
RUN mix phx.digest


CMD mix phx.server
