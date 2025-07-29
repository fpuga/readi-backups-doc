#!/bin/bash -i
# We use -i to read .bashrc and have commands like rmvirtualenv available

set -euo pipefail

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

PYTHON_VERSION=3.12.2
PROJECT_NAME="readi-backups-doc"

cd "${this_dir}"/..

# Clean up
command -v deactivate && deactivate

: "${PROJECT_NAME}" # checks that project_name exists, if not an unbound variable is raised

# virtualenv commands print weird warnings with set -u
(set +u && rmvirtualenv "${PROJECT_NAME}")

# Developer Experience Setup
if ! pyenv versions | grep "${PYTHON_VERSION}" > /dev/null 2>&1; then
    pyenv update
    pyenv install "${PYTHON_VERSION}"
fi
PYTHON_VERSION_BINARY_PATH="$(pyenv shell "${PYTHON_VERSION}" && pyenv which python)"

set +u
# https://github.com/pexpect/pexpect/commit/71bbdf52ac153c7eaca631637ec96e63de50c2c7
mkvirtualenv -p "${PYTHON_VERSION_BINARY_PATH}" -a . "${PROJECT_NAME}" || true
set -u

if ! command -v deactivate; then
    echo "Not in a virtualenv. Can not continue."
    exit 1
fi

# Para algunos plugins
sudo apt install libcairo2-dev libfreetype6-dev libffi-dev libjpeg-dev libpng-dev libz-dev pngquant

python -m pip install --upgrade pip
python -m pip install --upgrade build
pip install -r requirements.txt
pip install -r requirements-dev.txt

npm install
pre-commit clean
pre-commit gc
pre-commit install --install-hooks --overwrite

echo "* DONE :)"
