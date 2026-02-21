---
name: fastq-dl
description: `fastq-dl` is a specialized command-line utility designed to streamline the retrieval of sequencing data from the ENA and SRA.
homepage: https://github.com/rpetit3/fastq-dl
---

# fastq-dl

## Overview
`fastq-dl` is a specialized command-line utility designed to streamline the retrieval of sequencing data from the ENA and SRA. Rather than manually navigating web portals or managing complex API queries, you can provide a single accession number to fetch all associated FASTQ files. The tool automatically handles metadata lookups via the ENA Data Warehouse API, manages download retries, and can merge multiple sequencing runs into single files based on experimental or sample-level groupings.

## Core CLI Patterns

### Basic Downloads
The most common use case is downloading all runs associated with a specific accession. By default, the tool attempts to download from ENA first, then falls back to SRA.
```bash
# Download all runs for a BioProject
fastq-dl --accession PRJNA248678

# Download a specific Experiment
fastq-dl --accession SRX477044
```

### Provider Management
While ENA is the default (providing direct FASTQ access), you can force or prioritize a specific provider.
```bash
# Prioritize SRA
fastq-dl --accession PRJNA248678 --provider sra

# Only use ENA (no fallback to SRA if ENA fails)
fastq-dl --accession PRJNA248678 --provider ena --only-provider
```

### Merging and Grouping
Sequencing projects often have multiple runs (ERR/SRR) for a single sample or experiment. Use grouping flags to automatically merge these into a single FASTQ file.
```bash
# Merge all runs belonging to the same sample
fastq-dl --accession PRJNA248678 --group-by-sample

# Merge all runs belonging to the same experiment
fastq-dl --accession PRJNA248678 --group-by-experiment
```

### Metadata and Optimization
```bash
# Retrieve only the metadata TSV without downloading large FASTQ files
fastq-dl --accession PRJNA248678 --only-download-metadata

# Use SRA Lite (simplified Q30 quality scores) to save disk space
fastq-dl --accession PRJNA248678 --provider sra --sra-lite

# Increase CPUs for SRA downloads (conversion process)
fastq-dl --accession PRJNA248678 --cpus 8
```

## Expert Tips & Best Practices

- **Accession Flexibility**: The tool accepts a wide range of prefixes including BioProject (PRJ...), Study (ERP/SRP...), BioSample (SAM...), Sample (ERS/SRS...), Experiment (ERX/SRX...), and Run (ERR/SRR...).
- **Output Verification**: Always check the generated `<prefix>-run-info.tsv` file. It contains the definitive metadata for every run processed during the command execution.
- **Checksums**: By default, `fastq-dl` verifies MD5 checksums. If you encounter persistent failures due to network-level corruption and want to keep partial files, use `--ignore`, though this is generally discouraged for data integrity.
- **Storage Efficiency**: If base quality scores are not the primary focus of your analysis (e.g., simple mapping or abundance counting), `--sra-lite` significantly reduces the footprint of SRA-sourced data.
- **Rate Limiting**: If you encounter API blocks, increase the `--sleep` interval (default is 10 seconds) to be more polite to the ENA/SRA servers.

## Reference documentation
- [fastq-dl GitHub Repository](./references/github_com_rpetit3_fastq-dl.md)
- [fastq-dl Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastq-dl_overview.md)