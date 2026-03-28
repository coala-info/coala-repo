---
name: mtsv
description: MTSv is a metagenomic analysis suite that identifies taxa in shotgun sequencing samples by finding signature reads unique to specific organisms. Use when user asks to prepare reference databases, run a taxonomic classification pipeline, or extract reads associated with specific TaxIDs.
homepage: https://github.com/FofanovLab/MTSv
---

# mtsv

## Overview

MTSv is a high-performance metagenomic analysis suite designed to identify taxa in shotgun sequencing samples by finding signature reads unique to specific organisms. The tool operates through a two-stage process: first, a one-time setup of sequence databases (GenBank/RefSeq) using `mtsv_setup`, followed by a modular analysis pipeline using the `mtsv` command. It leverages Snakemake for workflow management, allowing for scalable execution on local machines or high-performance computing clusters.

## Database Setup and Management

Before running analysis, you must prepare the reference database. This is handled by the `mtsv_setup` utility.

### Standard Database Creation
Download and build the default GenBank and RefSeq "Complete Genome" databases:
`mtsv_setup database --path ./db_dir --thread 8`

### Custom Database Partitions
To focus on specific organisms and speed up analysis, create custom FM-indices using TaxIDs:
- **Include specific TaxIDs**: `mtsv_setup custom_db --path ./db_dir --partition 1396,1392`
- **Exclude specific TaxIDs**: Use the minus sign (e.g., Bacilli 91061 excluding B. anthracis 1392): `mtsv_setup custom_db --path ./db_dir --partition 91061-1392`

## Analysis Workflow

The analysis pipeline requires a configuration file (`mtsv.cfg`) generated during initialization.

### 1. Initialization
Generate the required config file by pointing to the database artifacts:
`mtsv init /path/to/database/artifacts/genbank.json`

### 2. Running the Pipeline
Execute the full suite from quality control to statistical analysis:
`mtsv pipeline --configfile mtsv.cfg --cores 16`

### 3. Modular Execution
You can run specific stages of the pipeline independently:
- **Readprep**: QC and kmer generation: `mtsv readprep --configfile mtsv.cfg`
- **Binning**: Alignment-based classification: `mtsv binning --configfile mtsv.cfg`
- **Summary**: Taxa hit summarization: `mtsv summary --configfile mtsv.cfg`
- **Analyze**: Statistical validation: `mtsv analyze --configfile mtsv.cfg`

## Expert Tips and Best Practices

- **Input Format**: MTSv typically expects raw FASTQ files. Note that some versions may not support gzipped FASTQ directly; if errors occur, decompress files before running `readprep`.
- **Snakemake Integration**: Since `mtsv` wraps Snakemake, you can pass native Snakemake arguments like `--dry-run`, `--unlock`, or `--rerun-incomplete` directly to the `mtsv pipeline` command.
- **Cluster Execution**: For HPC environments, use `mtsv cluster-init` to generate a `cluster.cfg`. Execute using the `--cluster` flag to map Snakemake rules to your scheduler (e.g., SLURM).
- **Extracting Reads**: Use `mtsv extract --taxid <ID>` to pull all queries that aligned to a specific taxon for downstream validation or assembly.
- **Unaligned Reads**: Use `mtsv extract-unaligned` to isolate reads that failed to match the database, which is useful for identifying novel organisms or contamination.



## Subcommands

| Command | Description |
|---------|-------------|
| mtsv | mtsv: error: argument COMMAND: invalid choice: 'COMMAND' (choose from 'init', 'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline') |
| mtsv | mtsv: error: argument COMMAND: invalid choice: 'coming' (choose from 'init', 'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline') |
| mtsv analyze | Additional Snakemake commands may also be provided |
| mtsv binning | Additional Snakemake commands may also be provided |
| mtsv extract | Extracts reads based on taxonomic IDs and other criteria. |
| mtsv init | Initialize mtsv project |
| mtsv readprep | Additional Snakemake commands may also be provided |
| mtsv summary | Additional Snakemake commands may also be provided |
| mtsv_pipeline | Additional Snakemake commands may also be provided |

## Reference documentation

- [Binning and Analysis Quick Start Guide](./references/github_com_FofanovLab_MTSv_wiki_Binning-and-Analysis-Quick-Start-Guide.md)
- [Sequence Download and Setup Quick Start Guide](./references/github_com_FofanovLab_MTSv_wiki_Sequence-Download-and-Setup-Quick-Start-Guide.md)
- [Custom Partitioning of Selected Database](./references/github_com_FofanovLab_MTSv_wiki_Custom-Partitioning-of-Selected-Database.md)
- [Installation Guide](./references/github_com_FofanovLab_MTSv_wiki_Installation.md)