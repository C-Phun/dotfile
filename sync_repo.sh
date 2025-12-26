#!/usr/bin/env -S bash -x

git add .
if command -v pre-commit &>/dev/null; then
  pre-commit run
fi
git add -u
# git submodule update --recursive --remote

WHO=
if [[ -v OS ]]; then
  WHO="${OS,,}"
elif [[ "$(uname -r)" == *"WSL"* ]]; then
  WHO="wsl-$WSL_DISTRO_NAME"
elif [[ -v TERMUX_VERSION ]]; then
  WHO="termux"
elif [[ -v HOSTNAME ]]; then
  WHO=$HOSTNAME
else
  WHO="fydeos"
fi
git commit -m "$WHO - $(date +'%a-%d-%b %H:%M%:::z')"

# git add -u
git config pull.rebase false
git pull --recurse-submodule=no
git push
