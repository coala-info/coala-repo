---
name: seshat
description: Seshat is a specialized toolset designed to bridge the gap between local VCF files and the Seshat TP53 database webserver.
homepage: https://github.com/clintval/tp53
---

# seshat

## Overview
Seshat is a specialized toolset designed to bridge the gap between local VCF files and the Seshat TP53 database webserver. Because the Seshat webserver lacks a public API and returns results via email, this tool automates the browser-based upload process and the subsequent retrieval of results from Gmail. It is essential for bioinformatics workflows requiring high-confidence TP53 functional annotations.

## Installation and Requirements
Install via Bioconda:
```bash
conda install seshat
```
**Dependencies:**
- **Google Chrome:** Required for headless browser automation.
- **Gmail API:** A `credentials.json` file is required for the `find-in-gmail` and `round-trip` commands.
- **macOS Note:** You may need to manually authenticate the Chrome driver if prompted by the OS.

## Common CLI Patterns

### Full Annotation Workflow (Round-trip)
The most efficient way to use the tool is the `round-trip` command, which handles the upload, waits for the email, and merges the results.
```bash
seshat round-trip \
  --input "sample.vcf" \
  --output "annotated_sample" \
  --email "user@example.com"
```

### Manual Step-by-Step Execution
If you prefer to separate the upload and retrieval phases:

1. **Upload VCF:**
   ```bash
   seshat upload-vcf \
     --input "sample.vcf" \
     --email "user@example.com" \
     --assembly hg38
   ```

2. **Retrieve from Gmail:**
   ```bash
   seshat find-in-gmail \
     --input "sample.vcf" \
     --output "results_prefix" \
     --credentials "~/.secrets/credentials.json"
   ```

## Expert Tips and Best Practices

### Pre-processing VCFs
Seshat often fails to parse VCFs containing Structural Variants (SVs). It is a best practice to strip SVs before submission to ensure the webserver can process the file.
```bash
# Exclude variants with a non-empty SVTYPE
bcftools view sample.vcf --exclude 'SVTYPE!="."' > sample.noSV.vcf
```

### Resource Respect
The tool interacts with a shared community resource. To maintain service availability:
- **Minimize Load:** Avoid rapid-fire requests; use the `--wait-for` flags if performing batch operations.
- **Minimize Connections:** Do not run multiple concurrent `upload-vcf` instances.

### Troubleshooting Gmail Retrieval
If `find-in-gmail` fails to locate your results:
- Ensure the `--input` filename matches the file originally uploaded.
- Check that the `credentials.json` has the necessary scopes for Gmail read access.
- Use the `--newer-than` flag (in hours) to narrow the search if you have many historical Seshat emails.

## Reference documentation
- [Seshat Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seshat_overview.md)
- [Seshat GitHub Repository](./references/github_com_clintval_tp53.md)