---
name: drax
description: DRAX is a bioinformatics pipeline that identifies antibiotic resistance genes and performs taxonomic classification to determine their host organisms in metagenomic samples. Use when user asks to identify resistance genes, extract genomic neighborhoods, or perform host-association analysis for ARGs.
homepage: https://github.com/will-rowe/drax
---


# drax

## Overview

DRAX is a specialized bioinformatics pipeline that bridges the gap between identifying resistance genes and understanding which organisms carry them in a metagenomic sample. It integrates three primary tools: GROOT for ARG detection, Metacherchant for extracting the genomic neighborhood of those genes, and Kaiju for taxonomic classification of the resulting sequences. This workflow allows researchers to move beyond simple resistome profiling to host-association analysis.

## Installation and Setup

DRAX is primarily distributed via Bioconda. It is recommended to install it within a dedicated environment.

```bash
conda install drax -c bioconda
```

### Database Initialization
Before running the pipeline for the first time, you must download the reference databases. This includes masked hg19 for decontamination, ResFinder for ARG detection, and the Kaiju RefSeq database.

```bash
# Downloads ~10GB of compressed data to ./DRAX-files by default
drax get
```

## Command Line Usage

### Standard Execution
The `drax` wrapper script is the simplest way to run the pipeline. You must provide the path to your sequencing reads and the directory containing the reference data downloaded during the setup phase.

```bash
drax --reads 'path/to/data/*R{1,2}.fq.gz' --refData ./DRAX-files
```

### Direct Nextflow Execution
If you prefer to run the pipeline directly via Nextflow (e.g., to use specific profiles like Docker or Singularity), use the following patterns:

**Using Docker:**
```bash
nextflow run will-rowe/drax --reads 'tests/*R{1,2}.fq.gz' -profile docker
```

**Using Singularity:**
```bash
nextflow run will-rowe/drax --reads 'tests/*R{1,2}.fq.gz' -with-singularity 'docker://wpmr/drax'
```

## Best Practices and Tips

- **Read Patterns**: Always wrap your read file patterns in single quotes (e.g., `'*R{1,2}.fq.gz'`) to prevent the shell from expanding the glob before it reaches the pipeline.
- **Reference Data**: Ensure you have at least 15-20GB of free disk space before running `drax get`, as the databases are large once uncompressed.
- **Resource Management**: When running on a local machine, monitor memory usage during the Kaiju classification step, as RefSeq-based taxonomic assignment can be memory-intensive.
- **Updates**: Running `drax get` also checks for and applies updates to the pipeline logic itself.

## Reference documentation
- [Bioconda drax Overview](./references/anaconda_org_channels_bioconda_packages_drax_overview.md)
- [DRAX GitHub Repository](./references/github_com_will-rowe_drax.md)