# ADarko22 Homebrew Tap

This is the official Homebrew Tap for tools maintained by [ADarko22](https://github.com/ADarko22).

## Installation

First, add this tap to your local Homebrew installation:

```bash
brew tap ADarko22/tap
```

## Tools

### JDKCertsTool

[JDKCertsTool](https://github.com/ADarko22/JDKCertsTool) is a command-line utility to manage certificates in all the
installed JDKs discovered. It uses [keytool](https://docs.oracle.com/javase/10/tools/keytool.htm) under the hood.

```bash
brew install jdkcerts
```

## Requirements

Most tools in this tap are Java-based.

Java 21: The formulas are configured to depend on openjdk@21. Homebrew will attempt to install this automatically if you
don't have it.

## How it Works (For Maintainers)

This repository is updated automatically via GitHub Actions. When a new release is published in a tool's primary
repository (e.g., JDKCertsTool), a [repository_dispatch](https://github.com/marketplace/actions/repository-dispatch)
event is sent to this tap to update the corresponding formula with the new version and SHA256 checksum.

### Manual Update

You can manually trigger an update for a specific version using the GitHub CLI, for example with:

```Bash
gh workflow run release-formulae.yml \
--repo ADarko22/homebrew-tap \
-f formula_name=jdkcerts \
-f version=v1.0.1 \
-f artifact_name=JDKCertsTool-v1.0.1.jar
```