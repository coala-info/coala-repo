---
name: dig2
description: The dig2 tool performs theoretical protein digestion and simulates gas-phase fragmentation patterns to predict peptide masses and fragment ions. Use when user asks to digest protein sequences into peptide fragments, simulate MS/MS fragmentation patterns, or predict fragment ions for mass spectrometry workflows.
homepage: http://www.ms-utils.org/dig2/dig2.html
metadata:
  docker_image: "quay.io/biocontainers/dig2:1.0--h7b50bb2_7"
---

# dig2

## Overview
The `dig2` tool is a lightweight, flexible command-line utility designed for the theoretical digestion of proteins. It transforms protein sequences into peptide fragments based on user-defined cleavage rules. Beyond standard enzymatic digestion, it can simulate gas-phase fragmentation patterns, making it a valuable resource for predicting peptide masses and fragment ions in mass spectrometry workflows.

## Command Line Usage
The basic syntax for `dig2` requires piping a FASTA file into the executable followed by specific settings:

```bash
dig2 < input.fasta [settings]
```

### Common Settings and Parameters
While specific enzyme flags are defined in the settings string, the following patterns are standard:

- **Standard Digestion**: Define the cleavage site (e.g., after K or R for Trypsin).
- **MS/MS Simulation**: Use settings to specify fragmentation types like CID (Collision-Induced Dissociation) or ETD (Electron-Transfer Dissociation).
- **Help Menu**: To view the full list of available enzyme codes and modification parameters, use:
  ```bash
  dig2 -h
  ```

## Best Practices
- **Input Formatting**: Ensure the FASTA file is properly formatted with standard headers. `dig2` reads from `stdin`, so redirection (`<`) or piping (`cat file.fasta | dig2 ...`) is necessary.
- **Fragment Prediction**: When simulating MS/MS, remember that `dig2` generates theoretical fragments; these are useful for creating inclusion lists or verifying experimental spectra.
- **Performance**: Because it is written in C, `dig2` is highly efficient for processing large proteome-scale FASTA files.

## Reference documentation
- [dig2 Overview and Installation](./references/anaconda_org_channels_bioconda_packages_dig2_overview.md)
- [dig2 Official Documentation and Compilation Guide](./references/www_ms-utils_org_dig2_dig2.html.md)