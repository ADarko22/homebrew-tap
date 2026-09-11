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

Dependencies are formula-specific — see each formula for what it needs. `jdkcerts` is a self-contained native
binary and requires no runtime dependency (no JDK needed to run it).

## How it Works (For Maintainers)

This is a **generic Homebrew tap repository** that can support multiple tools from different repositories. Formula
files in `Formula/` are not necessarily hand-maintained — a tool's own release pipeline may generate and push its
formula here directly.

### For Maintainers - Adding New Tools

#### 1. Create a Formula

Create a new formula file in the `Formula/` directory. Key considerations:

- Formula name should match the command users install (e.g., `my-tool.rb` → `brew install my-tool`)
- Configure dependencies appropriate to your tool (Java, Python, etc.), or none if it ships a self-contained binary
- Update homepage, description, and test command to match your tool

#### 2. Set up automatic updates

Each tool is responsible for pushing its own formula updates to this tap from its own release pipeline, using a PAT
with `repo` scope on both the tool's repository and this tap. The mechanism is up to the tool — it does not need to
match other formulas in this tap.

`jdkcerts` uses [`Justintime50/homebrew-releaser`](https://github.com/Justintime50/homebrew-releaser) as a step in
[JDKCertsTool's own release workflow](https://github.com/ADarko22/JDKCertsTool/blob/master/.github/workflows/release.yml):
it downloads that release's platform binaries, computes their checksums, generates a `brew audit`-compliant
`Formula/jdkcerts.rb`, and pushes it here directly. **`Formula/jdkcerts.rb` is auto-generated on every JDKCertsTool
release — do not hand-edit it; changes will be overwritten on the next release.**

This is specific to `jdkcerts`, not a tap-wide policy — a different tool added to this tap can use a different
update mechanism (e.g. a `repository_dispatch`-triggered workflow in this repo, if a future tool's release process
calls for it).