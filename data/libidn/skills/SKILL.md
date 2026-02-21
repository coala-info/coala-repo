---
name: libidn
description: The `libidn` skill provides procedural knowledge for using the `idn2` command-line utility (from the Libidn2 library).
homepage: https://github.com/libidn/libidn2
---

# libidn

## Overview
The `libidn` skill provides procedural knowledge for using the `idn2` command-line utility (from the Libidn2 library). It is the modern implementation of the IDNA2008, Punycode, and Unicode TR46 specifications. Use this skill to handle domain names containing non-ASCII characters (e.g., "müller.de"), which must be converted to a "Punycode" format (e.g., "xn--mller-kva.de") to be processed by standard DNS infrastructure.

## Common CLI Patterns

### Basic Conversion
The default behavior of `idn2` is to convert UTF-8 input to ASCII (ACE).

*   **Convert Unicode to ASCII (Punycode):**
    ```bash
    idn2 müller.de
    ```
*   **Convert ASCII (Punycode) to Unicode:**
    Use the `-d` or `--decode` flag.
    ```bash
    idn2 --decode xn--mller-kva.de
    ```

### Processing Multiple Inputs
*   **Interactive/Pipe Mode:**
    If no argument is provided, `idn2` reads from standard input.
    ```bash
    echo "müller.de" | idn2
    ```
*   **Batch Processing:**
    Process a list of domains from a file.
    ```bash
    idn2 < domains.txt
    ```

### Standard Compliance Flags
Depending on your use case, you may need to specify which IDNA standard to follow:

*   **IDNA2008 (Default):**
    Strict adherence to the IDNA2008 protocol.
    ```bash
    idn2 --idna2008 müller.de
    ```
*   **TR46 (Unicode IDNA Compatibility Processing):**
    Often used for web browsers to handle transitions between IDNA2003 and IDNA2008.
    ```bash
    idn2 --tr46 müller.de
    ```

## Expert Tips

### Lookup vs. Registration
*   **Lookup (Default):** Use this for resolving domain names. It is more permissive and handles mapping (like case folding).
*   **Registration:** Use the `--register` flag when validating a domain name for registration. This is stricter and ensures the name is valid for entry into a registry.

### Handling Input Encodings
While `idn2` assumes UTF-8 by default, you can specify the local system encoding if necessary using the `--usestdinput` flag or ensuring your environment's `LANG` variable is set correctly. For programmatic use, always prefer UTF-8.

### Quiet Output
For use in scripts where only the result is needed without headers or extra information, use the `--quiet` or `-q` flag.
```bash
punycode_domain=$(idn2 --quiet müller.de)
```

## Reference documentation
- [Libidn2 README](./references/github_com_libidn_libidn2.md)