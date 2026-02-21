---
name: zarp
description: ZARP is a user-friendly command-line interface designed to streamline RNA-Seq analysis.
homepage: https://github.com/zavolanlab/zarp-cli
---

# zarp

## Overview
ZARP is a user-friendly command-line interface designed to streamline RNA-Seq analysis. It automates the often-tedious process of metadata discovery by using the HTSinfer package to identify library types, organisms, and other essential parameters before running a standardized Snakemake-based analysis pipeline. It is particularly useful for researchers handling large batches of samples, public datasets from the Sequence Read Archive (SRA), or complex mixtures of single-end and paired-end libraries.

## Core CLI Usage

### Initialization
Before running analyses, set up user defaults and configurations:
```bash
zarp --init
```

### Input Patterns
ZARP accepts multiple input formats directly as positional arguments:

*   **Single-end libraries**: Provide the path to the FASTQ file.
    `zarp sample_1.fq.gz`
*   **Paired-end libraries**: Use a comma to separate mates.
    `zarp mate_1.fq.gz,mate_2.fq.gz`
*   **SRA Accessions**: Provide the SRR ID directly.
    `zarp SRR0123456789`
*   **Sample Tables**: Use the `table:` prefix followed by the path to a TSV file.
    `zarp table:samples.tsv`

### Assigning Sample Names
By default, ZARP derives sample names from filenames or IDs. To manually assign a name, use the `@` symbol:
```bash
zarp my_custom_name@path/to/file.fq.gz
zarp experimental_rep1@SRR0123456789
```

### Batch Processing
You can mix and match all input types in a single command execution:
```bash
zarp \
  sample_1.fq.gz \
  mate_1.fq.gz,mate_2.fq.gz \
  table:metadata.tsv \
  SRR0123456789
```

## Expert Tips and Best Practices

*   **Metadata Inference**: ZARP uses HTSinfer to fill in gaps. If your samples have non-standard headers or unusual library preps, use `--verbosity DEBUG` to monitor how ZARP is interpreting your data.
*   **Environment Management**: Ensure you are working within the `zarp-cli` conda environment. If you lack root privileges, use the `install/environment.yml` file during setup instead of the root version.
*   **SRA Efficiency**: When "ZARPing" SRA runs, the tool handles the download and processing. This is significantly faster than manually downloading with `fastq-dump` and then configuring a pipeline.
*   **Verbosity Control**: Use `--verbosity` levels (DEBUG, INFO, WARN, ERROR, CRITICAL) to manage log output. INFO is the default, but WARN is recommended for stable production runs to highlight only potential issues.

## Reference documentation
- [ZARP-cli GitHub Repository](./references/github_com_zavolanlab_zarp-cli.md)
- [Bioconda ZARP Package Overview](./references/anaconda_org_channels_bioconda_packages_zarp_overview.md)