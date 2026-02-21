---
name: hunspell-en-med
description: This skill provides guidance for utilizing the `hunspell-en-med-glut` dictionary, a specialized resource for the Hunspell spell-checker.
homepage: https://github.com/glutanimate/hunspell-en-med-glut
---

# hunspell-en-med

## Overview

This skill provides guidance for utilizing the `hunspell-en-med-glut` dictionary, a specialized resource for the Hunspell spell-checker. It merges multiple medical databases to provide coverage for FDA-approved drug names (trade and generic), anatomical, dermatological, and internal medicine terms, as well as DSM-IV and ICD-9 codes. Use this tool to ensure technical accuracy in medical writing and to automate the validation of clinical text.

## CLI Usage and Best Practices

### Basic Spell-Checking
To check a file using both the standard American English dictionary and the medical extension, use the `-d` flag with a comma-separated list:

```bash
hunspell -d en_US,en_med_glut document.txt
```

### Programmatic Processing (Pipe Mode)
For automated workflows or scripts, use the `-a` flag to process text from stdin. This is useful for filtering lists of terms or checking individual strings:

```bash
echo "acetaminophen" | hunspell -d en_US,en_med_glut -a
```

### Installation and Setup
The dictionary file (`en_med_glut.dic`) must be placed in the system's hunspell directory to be recognized by the `-d` flag.

1.  **Copy Dictionary**: Place the `.dic` file in `/usr/share/hunspell/`.
2.  **System Integration**: On Debian/Ubuntu systems, it is recommended to create the directory `/var/lib/dictionaries-common/hunspell` and copy the configuration file there to ensure the dictionary is registered correctly with system-wide tools.

### Expert Tips
*   **Dictionary Order**: Always list the standard language dictionary (e.g., `en_US`) before the medical dictionary (`en_med_glut`) to ensure common English words are prioritized.
*   **Handling False Positives**: If the tool flags a valid medical term, verify the spelling against the 2014 FDA approval list, as the dictionary's primary drug name source is based on that snapshot.
*   **LibreOffice Integration**: If using this dictionary with LibreOffice, ensure you are not affected by known Ubuntu language-support bugs. If the dictionary does not appear, check the system's `dictionaries-common` configuration.

## Reference documentation
- [Hunspell Dictionary of English Medical Terms](./references/github_com_glutanimate_hunspell-en-med-glut.md)