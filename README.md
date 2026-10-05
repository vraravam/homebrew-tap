# homebrew-tap

Homebrew tap for any custom libraries by vraravam.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Homebrew](https://img.shields.io/badge/homebrew-tap-orange?logo=homebrew)](https://github.com/vraravam/homebrew-tap)

[![Lint](https://github.com/vraravam/homebrew-tap/actions/workflows/lint.yml/badge.svg)](https://github.com/vraravam/homebrew-tap/actions/workflows/lint.yml)

## Install

Each command uses the fully qualified name, which taps this repository if needed and trusts only that one formula or cask, not the whole tap (see Homebrew's [Tap Trust](https://docs.brew.sh/Tap-Trust#installing-from-a-tap)).

```sh
# git-remote-gpg-encrypt (formula)
brew install vraravam/tap/git-remote-gpg-encrypt

# mechvibes-dx (cask, Apple Silicon)
brew install --cask vraravam/tap/mechvibes-dx
```

To install by short name instead, trust the whole tap first: `brew tap vraravam/tap && brew trust vraravam/tap`.

### Currently supports the following:

[git-remote-gpg-encrypt](https://github.com/vraravam/git-remote-gpg-encrypt) [![GitHub tag](https://img.shields.io/github/v/tag/vraravam/git-remote-gpg-encrypt)](https://github.com/vraravam/git-remote-gpg-encrypt/tags)

[mechvibes-dx](https://github.com/vraravam/mechvibes-dx) (cask, Apple Silicon) [![GitHub release](https://img.shields.io/github/v/release/vraravam/mechvibes-dx)](https://github.com/vraravam/mechvibes-dx/releases)
