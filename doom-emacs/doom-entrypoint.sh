#!/bin/bash
set -eo pipefail

doom_d=$HOME/.doom.d

# re-generate ~/.doom.d/* configs if any of them is missing
[[ -r $doom_d/config.el && -r $doom_d/init.el && -r $doom_d/packages.el ]] ||
    doom install --no-env --no-install --no-fonts >/dev/null

exec emacs "$@"
