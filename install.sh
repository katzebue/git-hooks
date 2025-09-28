#!/bin/sh
set -e

REPO_URL="https://github.com/katzebue/git-hooks"
HOOKS_DIR="$(pwd)/.githooks"

echo "Installing git hooks..."

if [ ! -d "$HOOKS_DIR" ]; then
  echo "Downloading hooks from $REPO_URL..."
  curl -sSL "$REPO_URL/archive/refs/heads/main.tar.gz" \
    | tar -xz --strip=1 -C "$(pwd)" "git-hooks-main/.githooks"
fi

git config core.hooksPath "$HOOKS_DIR"

chmod +x "$HOOKS_DIR"/*

echo "✔️ Hooks installed from $HOOKS_DIR"
