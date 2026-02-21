---
name: htsinfer
description: HTSinfer is a diagnostic tool designed to analyze Illumina high-throughput sequencing (HTS) data to reconstruct missing metadata.
homepage: https://github.com/zavolanlab/htsinfer
---

# htsinfer

## Overview

HTSinfer is a diagnostic tool designed to analyze Illumina high-throughput sequencing (HTS) data to reconstruct missing metadata. By processing FASTQ files, it provides a standardized JSON output containing critical parameters required for downstream bioinformatics pipelines, such as mapping and quantification. Use this skill to verify sample integrity, automate workflow configurations, or identify the biological source of unknown sequencing libraries.

## Installation

HTSinfer is primarily distributed via Bioconda. To set up the environment:

```bash
conda install bioconda::htsinfer
```

## Command Line Usage

The tool accepts one (single-ended) or two (paired-ended) FASTQ files as input.

### Basic Patterns

**Single-ended library:**
```bash
htsinfer sample.fastq > metadata.json
```

**Paired-ended library:**
```bash
htsinfer sample_1.fastq sample_2.fastq > metadata.json
```

### Global Options

- `--verbosity`: Set the logging level (`DEBUG`, `INFO`, `WARN`, `ERROR`, `CRITICAL`). Use `DEBUG` for detailed troubleshooting of the inference logic.
- `--tax_id`: Manually provide a taxon ID to assist or validate the library source inference.

## Interpreting Results

The tool outputs a JSON object to `STDOUT`. Key fields include:

- **library_source**: Identifies the organism (e.g., `hsapiens`) and `taxon_id` (e.g., `9606`).
- **library_type**: Determines if the library is `single_mate` or `split_mates`.
- **read_orientation**: Provides orientation codes such as `SF` (Sense Forward), `SR` (Sense Reverse), or `ISF` (Inward Sense Forward for paired-end).
- **read_layout**: Reports detected 3' adapters (`adapt_3`) and the fraction of reads containing polyA tails (`polyA_frac`).
- **library_stats**: Provides read length statistics (min, max, mean, median, mode).

## Expert Tips and Best Practices

1. **Automated Pipelines**: Since the output is JSON, pipe the results into `jq` for easy extraction of specific metadata values in shell scripts.
2. **Log Management**: HTSinfer writes logs to `STDERR`. When running in a batch environment, redirect `STDOUT` to a file and `STDERR` to a log file to keep metadata and diagnostic info separate.
3. **Validation**: Use HTSinfer as a pre-processing check. If the inferred `library_source` does not match your expected organism, it may indicate sample contamination or a labeling error.
4. **Adapter Detection**: The tool is highly effective at identifying 3' adapters. Use the inferred `adapt_3` sequence to dynamically configure trimming tools like Cutadapt or Trimmomatic.
5. **Memory Optimization**: For very large files, ensure the environment has sufficient memory for the alignment-based inference steps (e.g., STAR or Salmon-based checks performed internally).

## Reference documentation

- [HTSinfer GitHub Repository](./references/github_com_zavolanlab_htsinfer.md)
- [HTSinfer Wiki](./references/github_com_zavolanlab_htsinfer_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_htsinfer_overview.md)