---
name: sneakernet-qc
description: sneakernet-qc automates the QA/QC process for primary genomic sequencing data by transforming raw reads into structured project directories and executing analysis plugins. Use when user asks to initialize project directories from raw sequencer output, run the standard suite of genomic analysis plugins, or skip specific pipeline steps like data egress.
homepage: https://github.com/lskatz/sneakernet
---

# sneakernet-qc

## Overview

SneakerNet is a modular bioinformatics pipeline designed to automate the QA/QC process for primary genomic sequencing data. It transforms raw reads into a structured project directory and executes a series of plugins to generate assemblies, identify taxa, and predict phenotypes. This skill provides the necessary command-line patterns to initialize project directories and execute the standard analysis suite, ensuring consistent and reproducible genomic surveillance.

## Core Workflow

### 1. Project Initialization
Before running the analysis, you must convert a raw sequencer output folder (e.g., from a MiSeq) into a SneakerNet-formatted project directory.

```bash
SneakerNet.roRun.pl --createsamplesheet -o PROJECT_NAME /path/to/miseq/run/directory
```

- **Note**: This creates the required `samples.tsv` and organizes the FASTQ files.
- **Tip**: If the sample sheet already exists, ensure it is in the root of the project directory.

### 2. Running the Pipeline
Execute the standard suite of plugins on an initialized project directory.

```bash
SneakerNetPlugins.pl --numcpus 8 ./PROJECT_NAME
```

### 3. Common Plugin Controls
You can skip specific steps (like data egress) using the `--no` flag:

- **Skip Emailing**: `--no email`
- **Skip File Transfer**: `--no transfer`
- **Skip Database Saving**: `--no save`

## Docker Usage Patterns

For environments using containers, use the following patterns to ensure volumes are mapped correctly for the Perl scripts.

**Importing Data:**
```bash
docker run --rm -v $PWD:/data lskatz/sneakernet:latest \
  SneakerNet.roRun.pl /data/MISEQ_RAW -o /data/SN_INPUT
```

**Running Analysis:**
```bash
docker run --rm -v $PWD:/data -v $KRAKEN_DB:/kraken-database \
  lskatz/sneakernet:latest \
  SneakerNetPlugins.pl --numcpus 12 --no email /data/SN_INPUT
```

## Expert Tips

- **Resource Management**: Always specify `--numcpus` to match your environment; the default may not be optimal for high-throughput assembly.
- **Contamination Checks**: SneakerNet uses Kraken and MLST-based checks. Ensure your Kraken database path is correctly set in the environment or mapped in Docker, otherwise, contamination plugins will fail.
- **Output Inspection**: The primary output is an HTML summary report (`report.html`) located in the project directory. This provides a high-level "Pass/Fail" status for every sample in the run.
- **Manual Overrides**: If a sample fails QC due to known issues, you can manually edit the `samples.tsv` or the plugin-specific TSV files in the project folder before re-running `SneakerNetPlugins.pl`.



## Subcommands

| Command | Description |
|---------|-------------|
| SneakerNet.roRun.pl | Parses an unaltered Illumina run and formats it into something usable for SneakerNet. Fastq files must be in the format of _R1_ and _R2_ instead of _1 and _2 for this particular script. |
| SneakerNetPlugins.pl | runs all SneakerNet plugins on a run directory |

## Reference documentation
- [SneakerNet README](./references/github_com_lskatz_SneakerNet_blob_master_README.md)
- [SneakerNet Dockerfile](./references/github_com_lskatz_SneakerNet_blob_master_Dockerfile.md)