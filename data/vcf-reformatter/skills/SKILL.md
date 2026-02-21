---
name: vcf-reformatter
description: VCF files often contain nested data and complex annotation strings (like VEP's CSQ or SnpEff's ANN fields) that are difficult to analyze directly.
homepage: https://github.com/flalom/vcf-reformatter
---

# vcf-reformatter

## Overview

VCF files often contain nested data and complex annotation strings (like VEP's CSQ or SnpEff's ANN fields) that are difficult to analyze directly. `vcf-reformatter` is a high-performance Rust tool designed to "flatten" these structures into clean, row-based tables. It provides intelligent transcript handling—allowing you to isolate the most severe functional consequences or expand all transcripts into separate rows—while maintaining high throughput via multi-threading and native compression support.

## Core CLI Patterns

### Basic Conversion
The simplest usage converts a VCF to a TSV, automatically detecting headers and flattening INFO fields.
```bash
vcf-reformatter input.vcf.gz
```

### Handling Functional Annotations
The tool automatically detects VEP and SnpEff annotations by default, but you can force specific parsers if needed.
*   **Most Severe Consequence (Recommended for analysis):** Filters to only the transcript with the highest impact.
    ```bash
    vcf-reformatter input.vcf.gz -t most-severe
    ```
*   **Split Transcripts:** Creates a new row for every transcript associated with a variant.
    ```bash
    vcf-reformatter input.vcf.gz -t split
    ```
*   **Force Annotation Type:**
    ```bash
    vcf-reformatter input.vcf.gz -a vep
    vcf-reformatter input.vcf.gz -a snpeff
    ```

### Generating MAF (Mutation Annotation Format)
Note: MAF support is currently in beta (v0.3.0).
```bash
vcf-reformatter input.vcf.gz \
  --output-format maf \
  --ncbi-build GRCh38 \
  --center "MySequencingCenter" \
  --sample-barcode "Sample_01"
```

### High-Performance Processing
For large cohorts or HPC environments, utilize multi-threading and direct compression to save disk I/O.
```bash
vcf-reformatter large_dataset.vcf.gz \
  --threads 0 \
  --compress \
  --output-dir ./results/ \
  --prefix filtered_study \
  --verbose
```

## Expert Tips & Best Practices

*   **Transcript Selection:** Use `-t most-severe` when performing statistical associations to avoid inflating variant counts. Use `-t split` only when you need to audit every possible biological effect across all isoforms.
*   **Thread Management:** Setting `--threads 0` allows the tool to auto-detect and utilize all available CPU cores, which can reach speeds up to 30,000 variants per second.
*   **Memory Constraints:** When generating MAF files for datasets exceeding 1 million variants, ensure the system has at least 16GB of RAM. For standard TSV flattening, memory usage is significantly lower.
*   **Excel Warning:** While the TSV output is compatible with Excel, be cautious of Excel's tendency to auto-format gene symbols (e.g., converting "SEPT7" to a date).
*   **HPC Usage:** Use the static binary (`vcf-reformatter-v0.3.0-linux-x86_64-static`) on clusters to avoid dependency issues with GLIBC versions.

## Reference documentation
- [VCF Reformatter GitHub README](./references/github_com_flalom_vcf-reformatter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vcf-reformatter_overview.md)