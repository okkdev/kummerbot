# Waiting for official elixir 1.11 contianer
# FROM elixir:1.11-alpine AS builder

# ENV MIX_ENV=prod

# RUN mix local.hex --force && \
#     mix local.rebar --force

# RUN mkdir /opt/app
# WORKDIR /opt/app

# COPY . .

# RUN mix deps.get
# RUN mix deps.compile
# RUN mix release

# TEMPORARY ELIXIR 1.11 BUILDER
FROM erlang:23-alpine AS builder

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.11.0" \
	LANG=C.UTF-8 \
    MIX_ENV=prod

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="80b02a8973d2a0becacf577f15b202273002ad9c4d9ef55d8910c8d433c99a59" \
	&& buildDeps=' \
		ca-certificates \
		curl \
		make \
	' \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
	&& apk del .build-deps

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

CMD ["./bin/kummerbot", "start"]
