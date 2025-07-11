#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

if ! command -v uv &> /dev/null; then
  echo "🔧 Installing uv..."
  curl -Ls https://astral.sh/uv/install.sh | bash
  export PATH="$HOME/.cargo/bin:$PATH"
  source ~/.bashrc
else
  echo "✅ uv already installed."
fi

export TMPDIR=/workspace/tmp
mkdir -p $TMPDIR

echo "📦 Installing git-lfs..."
apt update && apt install -y git-lfs
git lfs install

echo "📥 Cloning Qwen2.5-Math-1.5B..."
mkdir models
cd models
git clone https://huggingface.co/Qwen/Qwen2.5-Math-1.5B || echo "Model already cloned."
cd ..

echo "📦 Setting up Python environment with uv..."
uv sync --no-install-package flash-attn
uv sync

echo "🌱 Activating Python virtual environment..."
source .venv/bin/activate

echo "✅ Setup complete."