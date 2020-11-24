# Kummerbot

Discord Bot that pipes direct messages to a channel in a server.

This enables submission of anonymous messages to that channel. 

## Prerequisites

You need to have a Postgres database running.

## Setup Docker

1. Get the container `docker pull okkdev/kummerbot`
1. Run the container. Example: `docker run -e KUMMER_BOT_TOKEN=your_bot_token -e KUMMER_CHANNEL=your_kummer_channel -e KUMMER_DATABASE_URL=your_postgres_db_url -d okkdev/kummerbot`

## Environment variables

`KUMMER_BOT_TOKEN` - Discord bot token

`KUMMER_CHANNEL` - ID of the channel where the messages are sent

`KUMMER_DATABASE_URL` - URL to the Postgres database (default: `ecto://postgres:postgres@localhost/kummerbot_repo`)

(optional) `KUMMER_PREFIX` - prefix for the bot commands (default: `.`)

## Development

1. Clone repo
1. Set env vars
1. Get dependencies `mix deps.get`
1. Create database `mix ecto.create`
1. Run migrations `mix ecto.migrate`
1. Run the bot `mix run --no-halt`
