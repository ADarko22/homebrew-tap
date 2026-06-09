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

This is a **generic Homebrew tap repository** that can support multiple tools from different repositories. It uses
GitHub Actions workflows to automatically update formulas when new releases are published.

### For Maintainers - Adding New Tools

#### 1. Create a Formula

Create a new formula file in the `Formula/` directory. Use `jdkcerts.rb` as a template. Key considerations:

- Formula name should match the command users install (e.g., `my-tool.rb` → `brew install my-tool`)
- Configure dependencies appropriate to your tool (Java, Python, etc.)
- Update homepage, description, and test command to match your tool

#### 2. Setup Automatic Updates (via repository_dispatch)

In your tool's primary repository, add a GitHub Actions workflow that sends a `repository_dispatch` event to this
tap when a new release is published. You will need to:

1. Create a personal access token (PAT) with `repo` scope in your tool's repository
2. Add it as a secret named `TAP_DISPATCH_TOKEN` in your tool's GitHub repository
3. Replace `my-tool`, `owner`, and artifact paths with your actual values

#### 3. Manual Updates

You can manually trigger a formula update using the GitHub CLI. This is useful for testing or one-off updates:

```bash
# For JDKCertsTool (download_url defaults to ADarko22/JDKCertsTool, so it's optional)
gh workflow run release-formula.yml \
  --repo ADarko22/homebrew-tap \
  -f formula_name=jdkcerts \
  -f version=v1.0.1 \
  -f artifact_name=JDKCertsTool-v1.0.1.jar
```

#### 4. How the Update Workflow Works

- Downloads the specified artifact to calculate its SHA256 checksum
- Updates the formula's URL and checksum
- Commits and pushes changes to the main branch
- Homebrew users can then install or upgrade with `brew install/upgrade`