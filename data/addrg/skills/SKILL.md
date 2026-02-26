---
name: addrg
description: The addrg tool generates Bitcoin and altcoin addresses along with their corresponding private keys using a minimal and auditable codebase. Use when user asks to generate a Bitcoin address, create keys for altcoin networks using specific version bytes, or derive addresses from a passphrase.
homepage: https://github.com/weex/addrgen
---


# addrg

## Overview
The `addrg` skill provides a streamlined interface for generating Bitcoin addresses and their corresponding private keys. Based on the `addrgen` project, this tool is designed for maximum transparency and auditability, featuring a minimal codebase that allows users to verify the cryptographic operations easily. It is particularly useful for developers who need to generate keys for Bitcoin or other blockchain networks that use similar address versioning schemes without the overhead of large libraries.

## Usage Instructions

### Basic Address Generation
To generate a standard Bitcoin address using the compressed public key format:
```bash
python addrgen.py
```
This will output the generated Bitcoin address and its associated private key to the console.

### Generating Altcoin Addresses
You can generate addresses for other networks by providing the specific version byte associated with that network using the `--otherversion` flag.

**Example for Litecoin (Version 48):**
```bash
python addrgen.py --otherversion=48
```

### Advanced Configuration
While the CLI is intentionally minimal, the underlying script contains hooks for more complex operations. If you need to generate addresses based on a specific passphrase or a pre-existing private key, you should inspect the `test()` function within `addrgen.py`. The script includes commented-out lines that demonstrate how to:
- Initialize the generator with a specific passphrase.
- Import an existing private key to derive its public address.

## Best Practices and Expert Tips
- **Auditability**: Because the script is extremely small, always perform a quick manual review of `addrgen.py` before use in sensitive environments to ensure no modifications have been made to the entropy or key derivation logic.
- **Compressed Format**: By default, the tool uses the compressed public key format. Ensure your target wallet or service supports compressed keys (most modern Bitcoin services do).
- **Environment Security**: Always run this tool in a secure, offline environment if you are generating keys for significant amounts of cryptocurrency.
- **Version Bytes**: When using `--otherversion`, ensure you have the correct decimal version byte for the specific blockchain you are targeting (e.g., 0 for Bitcoin Mainnet, 48 for Litecoin).

## Reference documentation
- [addrgen - minimal Bitcoin address generator in Python](./references/github_com_weex_addrgen.md)