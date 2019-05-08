# Development Environment

Helper tool to operate various programming language environments that are
based on official Docker images.

## Supported programming languages / toolchains
* bash
* clojure
* elixir
* erlang
* gcc
* golang
* haskell
* julia
* node
* openjdk
* perl
* perl6
* python
* ruby
* rust

## Installation

Clone this repository and create a symlink to `devenv` script somewhere in your `$PATH`. For example:
```
cd ~/misc
git clone https://github.com/chumakd/devenv.git
sudo ln -s ~+/devenv/devenv /usr/local/bin/
```

## Examples

Run script in the current directory using latest version of Ruby interpreter:
```
devenv run ruby ./my-script.rb --script-opt script-arg
```

Initialize empty Rust project in the current directory with the latest Rust toolchain:
```
devenv run rust cargo new my-project
```

Start Haskell [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop):
```
devenv haskell-repl
```

Start interactive shell using latest Python image:
```
devenv python-shell
```

For more info please refer to `devenv --help`.
