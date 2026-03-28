---
name: seshat
description: Seshat automates the annotation of TP53 mutations by facilitating a round-trip data exchange between local VCF files and the Seshat TP53 database webserver. Use when user asks to annotate TP53 mutations, upload VCFs to the Seshat webserver, or retrieve annotation results from Gmail.
homepage: https://github.com/clintval/tp53
---

# seshat

## Overview

Seshat is a specialized tool designed to bridge the gap between local genomic data and the Seshat TP53 database webserver. It automates what is otherwise a manual process: uploading VCFs to a web interface and waiting for an email containing the results. By using a headless browser and the Gmail API, Seshat allows for a seamless "round-trip" annotation within a bioinformatics pipeline, specifically targeting TP53 mutation analysis.

## Installation and Environment Setup

Before using the CLI, ensure the environment is properly configured:

- **Install via Bioconda**: `conda install seshat`
- **Browser Requirement**: The tool requires Google Chrome to be installed for headless operations.
  - macOS: `brew install --cask google-chrome`
- **Gmail API**: To use the retrieval features, you must provide a `credentials.json` file for the Gmail service, typically stored in `~/.secrets/`.

## Common CLI Patterns

### Full Annotation Round-Trip
The most common use case is the `round-trip` command, which handles upload, wait-time, and retrieval in one step.

```bash
seshat round-trip \
    --input "sample.vcf" \
    --output "annotated_sample" \
    --email "your-email@example.com"
```

### Manual Upload
Use this to send a VCF to the server without immediately waiting for the result.

```bash
seshat upload-vcf \
    --input "sample.vcf" \
    --email "your-email@example.com" \
    --assembly hg38
```

### Retrieving Results
If an upload was performed previously, use this to search your Gmail for the specific results file.

```bash
seshat find-in-gmail \
    --input "sample.vcf" \
    --output "results_prefix" \
    --credentials "~/.secrets/credentials.json"
```

## Expert Tips and Best Practices

### VCF Pre-processing
Seshat's web parser is sensitive and may fail silently if it encounters complex records.
- **Remove Structural Variants (SVs)**: It is highly recommended to strip SVs before uploading, as they often cause parsing errors.
  ```bash
  bcftools view input.vcf --exclude 'SVTYPE!="."' > input.noSV.vcf
  ```

### Server Etiquette
The Seshat webserver is a shared resource. To maintain access and prevent service degradation:
- **Minimize Load**: Avoid rapid-fire requests; use the `--wait-for` parameters to allow the server time to process.
- **Minimize Connections**: Do not run many concurrent `round-trip` instances.

### Troubleshooting macOS Authentication
On some macOS distributions, the headless Chrome driver may be blocked by security settings. If the tool hangs during upload, you may need to manually authenticate the driver in System Settings or via the terminal.



## Subcommands

| Command | Description |
|---------|-------------|
| seshat_find-in-gmail | Finds emails in Gmail and annotates them. |
| seshat_merge | Merge VCF files with annotations. |
| seshat_round-trip | Seshat round-trip annotation tool |
| seshat_upload-vcf | Uploads a VCF file to Seshat for annotation. |

## Reference documentation
- [Seshat README](./references/github_com_clintval_tp53_blob_main_README.md)