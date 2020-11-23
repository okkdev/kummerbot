FROM elixir:1.11-alpine AS builder

ENV MIX_ENV=prod

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /opt/app
WORKDIR /opt/app

COPY . .

RUN mix deps.get
RUN mix deps.compile
RUN mix release


FROM alpine AS runner

RUN apk update && \
    apk add --no-cache bash

RUN mkdir /opt/app
WORKDIR /opt/app
COPY --from=builder /opt/app/_build/prod/rel/kummerbot .

COPY entrypoint.sh .

CMD ["./entrypoint.sh"]
