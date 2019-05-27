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

Set kummerbot message channel in `config.exs`:

```elixir
config :kummerbot,
    kummerchannel: your_kummerbot_message_channel_id
```
