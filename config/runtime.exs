import Config

config :nostrum,
  token: System.fetch_env!("BOT_TOKEN"),
  num_shards: :auto

config :kummerbot,
  kummer_channel: String.to_integer(System.fetch_env!("KUMMER_CHANNEL"))
