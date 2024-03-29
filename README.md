# QuickNote

## Production URL: https://quick-note.gigalixirapp.com/

I created this to quickly look up things I found myself googling over and over.

To start your Phoenix server:

- Create a docker container with `docker compose up -d`
- Install Elixir, Erlang, and Node.js with `asdf install`. You need to install `asdf` if you have not installed it yet.
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deploymnet

Deployed at [Gigalixir](https://www.gigalixir.com/)

After loggin into giglixir accout through cli

- Create a tag: `git tag tag-name`
- Push tags: `git push --tags`
- Simply run `git push gigalixir`
