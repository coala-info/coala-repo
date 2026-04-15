---
name: hunspell-de-med
description: This tool provides a German dictionary that combines standard vocabulary with medical terminology for spell-checking. Use when user asks to install a German medical dictionary, check medical documents for spelling, or replace the default German dictionary with medical terms.
homepage: https://github.com/glutanimate/hunspell-de-med-workaround
metadata:
  docker_image: "biocontainers/hunspell-de-med:v20160103-3-deb_cv1"
---

# hunspell-de-med

## Overview
This skill facilitates the deployment and use of a specialized German dictionary that combines standard German (frami) with medical terminology. It is designed as a workaround for environments where standalone medical dictionaries are difficult to integrate, providing a merged dictionary file that replaces or augments the default German spell-checker.

## Installation and Setup
To enable medical spell-checking, the dictionary files must be placed in the system's hunspell directory.

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Glutanimate/hunspell-de-med-workaround.git
   cd hunspell-de-med-workaround
   ```

2. **Deploy to system path**:
   Copy the provided files to the standard Hunspell directory. Note that this typically replaces the default German dictionary to ensure application compatibility.
   ```bash
   sudo cp de_DE_frami.dic /usr/share/hunspell/de_DE.dic
   sudo cp de_DE_frami.aff /usr/share/hunspell/de_DE.aff
   ```

## Command Line Usage
Once installed, you can use the dictionary directly via the `hunspell` CLI to check medical documents.

- **Check a file**:
  ```bash
  hunspell -d de_DE medical_report.txt
  ```

- **List available dictionaries**:
  Verify that `de_DE` is recognized by the system:
  ```bash
  hunspell -D
  ```

## Maintenance and Restoration
If you need to revert to the standard Ubuntu/Debian German dictionary without medical terms, reinstall the base package:

```bash
sudo apt-get install --reinstall hunspell-de-de-frami
```

## Expert Tips
- **Backup**: Always backup `/usr/share/hunspell/de_DE.dic` and `.aff` before overwriting them if you have custom user additions in the system-wide files.
- **Application Refresh**: After copying the files, restart LibreOffice or OpenOffice for the medical terms to be recognized in the GUI.
- **Encoding**: Ensure your input files are UTF-8 encoded, as the `frami` base dictionary expects modern character encoding for German umlauts.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_glutanimate_hunspell-de-med-workaround.md)