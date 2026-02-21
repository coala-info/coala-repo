---
name: fido
description: Fido is a specialized PowerShell utility designed to streamline access to official Microsoft retail ISOs.
homepage: https://github.com/pbatard/Fido
---

# fido

## Overview
Fido is a specialized PowerShell utility designed to streamline access to official Microsoft retail ISOs. While Microsoft often forces users through complex web interfaces or the Media Creation Tool (which generates non-deterministic images), Fido queries Microsoft's download APIs directly to retrieve official, verifiable retail links. This is essential for users who require specific builds, languages, or architectures (including ARM64) and wish to verify their downloads against official SHA-1 hashes for security and integrity.

## Command Line Usage

Fido operates as a PowerShell script (`Fido.ps1`). It can be run with a GUI (default) or via the command line for automation.

### Basic Syntax
```powershell
.\Fido.ps1 [-Win <Version>] [-Rel <Release>] [-Ed <Edition>] [-Lang <Language>] [-Arch <Architecture>] [-GetUrl]
```

### Common Parameters
- `-Win`: Specify the Windows version (e.g., `10`, `11`). Use `-Win List` to see available versions.
- `-Rel`: Specify the build/release (e.g., `22H2`, `Latest`). Use `-Rel List` to see releases for a chosen version.
- `-Ed`: Specify the edition (e.g., `Pro/Home`). Use `-Ed List` for options.
- `-Lang`: Specify the language (e.g., `English International`, `French`). Supports partial matches like `-Lang Int`.
- `-Arch`: Specify architecture (`x64`, `x86`, or `ARM64`).
- `-GetUrl`: Instead of starting the download, the script outputs the direct URL to the console.

## Expert Tips & Patterns

### Automated URL Retrieval
To integrate Fido into a larger automation pipeline without triggering a browser download, use the `-GetUrl` switch. This allows you to pass the link to tools like `curl`, `wget`, or `aria2c`.
```powershell
$isoUrl = .\Fido.ps1 -Win 11 -Rel Latest -Lang "English International" -GetUrl
```

### Handling ARM64 Downloads
Microsoft treats Windows 11 ARM64 as a separate SKU. Fido abstracts this complexity, allowing you to select ARM64 as an architecture under the standard Windows 11 selection.
```powershell
.\Fido.ps1 -Win 11 -Arch ARM64
```

### Listing Available Options
If you are unsure of the exact string required for a release or language, always use the `List` value to avoid errors.
```powershell
# Find the exact string for a specific Windows 10 release
.\Fido.ps1 -Win 10 -Rel List
```

### System Defaults
If parameters are omitted, Fido attempts to be "smart" by:
1. Defaulting to the most recent Windows version and release.
2. Matching the language and architecture of the current host system.

## Reference documentation
- [Fido README](./references/github_com_pbatard_Fido.md)
- [Fido Release Tags](./references/github_com_pbatard_Fido_tags.md)