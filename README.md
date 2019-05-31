# Kummerbot

Discord Bot that pipes direct messages to a channel in a server.
This enables submission of anonymous messages to that channel. 

## Setup

Create `dev.secret.exs` in `config/` with this content:

```elixir
use Mix.Config

config :nostrum,
  token: "your bot token",
  num_shards: :auto
```

Set bot id and kummerbot message channel in `dev.config.exs`:

```elixir
config :kummerbot,
    bot_id: your_bot_id,
    kummerchannel: your_kummerbot_message_channel_id
```

Set the environment variable:

```bash
$ MIX_ENV=dev
```