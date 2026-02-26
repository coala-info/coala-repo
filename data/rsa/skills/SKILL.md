---
name: rsa
description: The rsa skill automates the recovery of RSA private keys and the decryption of data by exploiting mathematical weaknesses in RSA implementations. Use when user asks to recover a private key from a public key, decrypt ciphertext using weak RSA parameters, or perform specific attacks like Wiener's or Hastad's broadcast attack.
homepage: https://github.com/RsaCtfTool/RsaCtfTool
---


# rsa

## Overview
The `rsa` skill leverages RsaCtfTool to automate the recovery of RSA private keys and the decryption of data. It is most effective when dealing with "textbook" RSA implementations where the modulus (n) is a semiprime or has other mathematical weaknesses. The tool aggregates dozens of attack vectors—including Wiener's attack, Hastad's broadcast attack, and various integer factorization methods like ECM and Pollard's p-1—into a single interface.

## Common CLI Patterns

### Key Recovery and Decryption
*   **Recover private key from a public key file**:
    `RsaCtfTool --publickey ./key.pub --private`
*   **Decrypt a file using a weak public key**:
    `RsaCtfTool --publickey ./key.pub --decryptfile ./ciphertext.bin`
*   **Decrypt a raw string**:
    `RsaCtfTool --publickey ./key.pub --decrypt <hex_or_base64_string>`

### Working with Raw Parameters
If you have the RSA parameters (n, e) instead of a `.pub` file:
*   **Attack using n and e**:
    `RsaCtfTool -n <modulus_integer> -e <exponent_integer> --private`
*   **Attack using n, e, and ciphertext**:
    `RsaCtfTool -n <n> -e <e> --decrypt <ciphertext>`

### Advanced Attack Selection
*   **Run a specific attack**:
    `RsaCtfTool --publickey ./key.pub --attack wiener`
*   **Run multiple specific attacks**:
    `RsaCtfTool --publickey ./key.pub --attack "wiener,boneh_durfee,fermat"`
*   **Attack multiple keys for common factors**:
    `RsaCtfTool --publickey "*.pub" --attack common_factors`

### Key Manipulation
*   **Dump parameters from a key**:
    `RsaCtfTool --publickey ./key.pub --dumpkey`
*   **Create a public key from n and e**:
    `RsaCtfTool -n <n> -e <e> --createpub > newkey.pub`

## Expert Tips and Best Practices
*   **Timeout Management**: Some attacks (like ECM or SIQS) can run indefinitely. Use `--timeout <seconds>` to prevent the tool from hanging on a single difficult factorization.
*   **FactorDB Integration**: The tool can check FactorDB automatically. If you have a known weak modulus, checking `factordb.com` manually or via the tool is often the fastest path to success.
*   **SageMath Advantage**: Ensure SageMath is installed and accessible. Many of the most powerful attacks (like lattice-based attacks) require SageMath to function.
*   **Input Formats**: The tool supports various formats for `n` and `e`, including decimal and hexadecimal (prefixed with `0x`).
*   **Verbosity**: Use `--verbosity DEBUG` if an attack is failing to understand which specific algorithm is encountering issues or if the key format is being parsed incorrectly.

## Reference documentation
- [RsaCtfTool Main README](./references/github_com_RsaCtfTool_RsaCtfTool.md)