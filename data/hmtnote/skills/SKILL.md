---
name: hmtnote
description: hmtnote annotates human mitochondrial variants in VCF files with functional, population, and pathogenicity metadata. Use when user asks to annotate mitochondrial VCF files, retrieve pathogenicity predictions, or export variant metadata to CSV format.
homepage: https://github.com/robertopreste/hmtnote
metadata:
  docker_image: "quay.io/biocontainers/hmtnote:0.7.2--pyhdfd78af_1"
---

# hmtnote

## Overview

hmtnote is a specialized bioinformatics tool for the functional annotation of human mitochondrial variants. It accepts VCF files as input and enriches them with mitochondrial-specific metadata. The tool is particularly useful for researchers looking to categorize variants into basic descriptors, population variability, and pathogenicity predictions. Note that while the tool is highly effective for historical data, the underlying HmtVar service has been reported as archived, so users should verify connectivity or use the offline mode.

## Installation and Setup

Install hmtnote via bioconda or pip (requires Python 3.6+):

```bash
conda install bioconda::hmtnote
# OR
pip install hmtnote
```

## Common CLI Patterns

### Standard Annotation
To annotate a VCF file with all available information (basic, cross-reference, variability, and predictions):

```bash
hmtnote annotate input.vcf annotated.vcf
```

### Selective Annotation
If you only require specific subsets of data, use the following flags to reduce processing time and output bloat:

*   **Basic (-b / --basic):** Core mitochondrial variant info.
*   **Cross-reference (-c / --crossref):** Links to external databases.
*   **Variability (-v / --variab):** Population frequency and variability data.
*   **Predictions (-p / --predict):** Pathogenicity and functional impact scores.

Example of combining specific flags:
```bash
hmtnote annotate input.vcf output.vcf --basic --variab
```

### Generating Tabular Data
For easier visual inspection in spreadsheet software, generate a CSV version of the annotated data alongside the VCF:

```bash
hmtnote annotate input.vcf output.vcf --csv
```

## Offline Workflow

Because hmtnote fetches data on the fly, it is best practice to download the database for local use, especially for large batches or environments without stable internet access.

1.  **Download the database:**
    ```bash
    hmtnote dump
    ```
2.  **Run annotation in offline mode:**
    ```bash
    hmtnote annotate input.vcf output.vcf --offline
    ```

## Python API Usage

hmtnote can be integrated directly into Python scripts for custom bioinformatics pipelines:

```python
from hmtnote import annotate

# Basic usage
annotate("input.vcf", "output.vcf", basic=True, variab=True)

# Offline usage with CSV export
annotate("input.vcf", "output.vcf", offline=True, csv=True)
```

## Expert Tips

*   **Archival Status:** The HmtVar database has faced availability issues. If the tool fails to connect, always attempt the `hmtnote dump` command first to see if a local cache can be established.
*   **VCF Compatibility:** Ensure your input VCF follows standard formatting. hmtnote is optimized for human mitochondrial coordinates (NC_012920.1).
*   **Memory Management:** When processing very large VCFs, prefer the CLI over the Python API to benefit from the tool's optimized stream handling.

## Reference documentation
- [HmtNote GitHub Repository](./references/github_com_robertopreste_HmtNote.md)
- [hmtnote Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hmtnote_overview.md)