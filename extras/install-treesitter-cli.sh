#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing dependencies for tree-sitter-cli"

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This installer supports apt-based Linux distributions only."
  exit 1
fi

sudo apt-get update
sudo apt-get install -y clang libclang-dev build-essential pkg-config curl

echo "==> Locating libclang"
LIBCLANG_PATH_CANDIDATE=""

for lib in /usr/lib/llvm-*/lib/libclang.so*; do
  if [ -e "$lib" ]; then
    LIBCLANG_PATH_CANDIDATE="$(dirname "$lib")"
    break
  fi
done

if [ -z "$LIBCLANG_PATH_CANDIDATE" ]; then
  for lib in /usr/lib/x86_64-linux-gnu/libclang.so*; do
    if [ -e "$lib" ]; then
      LIBCLANG_PATH_CANDIDATE="/usr/lib/x86_64-linux-gnu"
      break
    fi
  done
fi

if [ -z "$LIBCLANG_PATH_CANDIDATE" ]; then
  echo "Could not find libclang.so after installation."
  exit 1
fi

export LIBCLANG_PATH="$LIBCLANG_PATH_CANDIDATE"
echo "Using LIBCLANG_PATH=$LIBCLANG_PATH"

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo not found. Install Rust toolchain first (rustup/cargo)."
  exit 1
fi

echo "==> Installing tree-sitter-cli with cargo"
mkdir -p /tmp/cargo-target
CARGO_TARGET_DIR=/tmp/cargo-target cargo install tree-sitter-cli --locked

echo "==> Ensuring ~/.cargo/bin is in PATH"
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [ -f "$rc" ]; then
    if ! grep -Fq 'export PATH="$HOME/.cargo/bin:$PATH"' "$rc"; then
      printf '\nexport PATH="$HOME/.cargo/bin:$PATH"\n' >> "$rc"
      echo "Updated $rc"
    fi
  fi
done

export PATH="$HOME/.cargo/bin:$PATH"

echo "==> Verifying tree-sitter-cli"
tree-sitter --version

echo "==> Updating Neovim parsers"
nvim --headless "+TSUpdateSync" +qa

echo "Done. Restart your shell if PATH was updated."
