#!/usr/bin/env bash
# Registra el kernel "pln-env". Las librerías CUDA de pip (nvidia-*) y las de WSL
# se exponen vía LD_LIBRARY_PATH porque TensorFlow no las encuentra por sí solo.
set -euo pipefail
cd "$(dirname "$0")/.."

site_packages=$(uv run python -c "import site; print(site.getsitepackages()[0])")
cuda_libs=$(ls -d "$site_packages"/nvidia/*/lib | paste -sd:)

uv run python -m ipykernel install --user --name pln-env --display-name "pln-env" \
    --env LD_LIBRARY_PATH "$cuda_libs:/usr/lib/wsl/lib"
