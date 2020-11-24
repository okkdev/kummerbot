import Config

config :kummerbot, Kummerbot.Repo, url: "ecto://postgres:postgres@localhost/kummerbot_repo"

config :kummerbot, ecto_repos: [Kummerbot.Repo]
