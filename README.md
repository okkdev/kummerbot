# Kummerbot

Discord Bot

## Setup

Create `secret.exs` in `config/` with this content:

```elixir
use Mix.Config

config :nostrum,
  token: "your bot token",
  num_shards: :auto
```

Set bot id and kummerbot message channel in `config.exs`:

```elixir
config :kummerbot,
    bot_id: your_bot_id,
    kummerchannel: your_kummerbot_message_channel_id
```
