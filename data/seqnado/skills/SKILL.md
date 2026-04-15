---
name: seqnado
description: Seqnado fetches, organizes, and processes genomic sequence data from public databases. Use when user asks to fetch raw reads by accession ID, download FASTQ files from GEO or SRA, or run data processing pipelines.
homepage: https://alsmith151.github.io/SeqNado/
metadata:
  docker_image: "quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0"
---

# seqnado

## Overview
The `seqnado` tool streamlines the often cumbersome process of fetching genomic sequence data. It acts as a specialized downloader and organizer that interfaces with public databases to pull raw reads, ensuring they are correctly named and structured for downstream pipelines. Use this skill to generate precise CLI commands for data acquisition, bypassing manual download steps and ensuring reproducibility in sequence data retrieval.

## Command Line Usage
Seqnado is primarily used to fetch data based on Accession IDs (e.g., SRR, ERR, or DRR numbers).

### Basic Data Retrieval
To download a specific run and convert it to FASTQ format:
```bash
seqnado fetch SRR1234567
```

### Batch Processing
For multiple samples, provide a list of accessions:
```bash
seqnado fetch SRR1234567 SRR1234568 SRR1234569
```

### Output Management
Direct the downloaded sequences to a specific directory to maintain project organization:
```bash
seqnado fetch SRR1234567 --outdir ./raw_data/
```

## Expert Tips
- **Check Metadata First**: Before initiating large downloads, use the tool to inspect sample metadata to ensure the sequencing depth and platform match your experimental requirements.
- **Parallel Downloads**: When dealing with large cohorts, utilize the tool's ability to handle multiple accessions in a single command to optimize network throughput.
- **Disk Space**: Always verify available disk space before running `fetch`, as raw FASTQ files (especially paired-end data) can be several gigabytes per accession.



## Subcommands

| Command | Description |
|---------|-------------|
| seqnado config | Configure seqnado settings. |
| seqnado download | Download FASTQ files from GEO/SRA using a metadata TSV file and optionally generate a design file. |
| seqnado pipeline | Run the data processing pipeline for ASSAY (Snakemake under the hood). Any additional arguments are passed to Snakemake (e.g., `seqnado pipeline rna -n` for dry-run, `--unlock`, etc.). |
| seqnado_design | Generate a SeqNado design CSV from FASTQ files for ASSAY. If no assay is provided, multiomics mode is used. |
| seqnado_tools | Available Tools in SeqNado Pipeline |

## Reference documentation
- [Seqnado Overview](./references/anaconda_org_channels_bioconda_packages_seqnado_overview.md)