# webkontist
Web Interface for Kontist account holders


elixir 1.9.0
erlang 21.3.8


# How to install
The minimal setup requires `Elixir` and `PhoenixFramework` to be installed. Starting from scratch please follow [this](https://gist.github.com/loretoparisi/7f6f0bccf35551850068d9206fa7c8c6) boilerplate:

```sh
brew update
brew install elixir
mix local.hex
mix archive.install hex phx_new 1.4.3
cd webkontist
mix deps.get
cd assets && npm install
```

# How to run

```sh
mix phx.server
```

and point your browser to [http://localhost:4000](http://localhost:4000)


This app is just an experiment using Phoenix Liveview and Kontist www.kontist.com APIs to have a web interface to browse a Kontist bank account.

This is a WIP so please take it as it is :) 
