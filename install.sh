#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

if ! command -v uv &> /dev/null; then
  echo "Installing uv..."
  curl -Ls https://astral.sh/uv/install.sh | bash
  export PATH="$HOME/.cargo/bin:$PATH"
else
  echo "uv already installed."
fi

echo "Install all packages.. "
uv sync --no-install-package flash-attn
uv sync

echo "Installing git-lfs..."
apt update && apt install -y git-lfs
git lfs install

echo "Cloning Qwen2.5-Math-1.5B..."
cd models
git clone https://huggingface.co/Qwen/Qwen2.5-Math-1.5B || echo "Model already cloned."
cd ..

export TMPDIR=/workspace/tmp
mkdir -p $TMPDIR

pip install vllm
pip install wandb
pip install pandas
pip install together

echo "Setup complete."