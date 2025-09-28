# Git Hooks Repository

This repository contains reusable Git hooks (starting with `commit-msg`).
It enforces commit message style based on Conventional Commits and your team's ticket rules.

## Installation

Run the installer script:

```bash
curl -s https://raw.githubusercontent.com/katzebue/git-hooks/main/install.sh | bash
```

## Usage as a Git Submodule
Clone this repository or add it as a **git submodule** to your project:

```bash
git submodule add git@github.com:katzebue/git-hooks.git .githooks
git config core.hooksPath .githooks
```

## Running Tests

Tests are written with [bats-core](https://github.com/bats-core/bats-core).

Run all tests:

```bash
cd tests
bats commit_msg.bats
```
