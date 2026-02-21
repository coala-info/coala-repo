---
name: gambit
description: GAMBIT (Genomic Approximation Method for Bacterial Identification and Tracking) is a high-performance bioinformatics tool designed for the rapid classification of bacterial pathogens.
homepage: https://github.com/jlumpe/gambit
---

# gambit

## Overview

GAMBIT (Genomic Approximation Method for Bacterial Identification and Tracking) is a high-performance bioinformatics tool designed for the rapid classification of bacterial pathogens. It utilizes an extremely efficient genomic distance metric to compare unknown assemblies against a curated database of approximately 50,000 reference genomes derived from NCBI RefSeq. This allows for species-level identification of bacterial isolates in seconds, making it significantly faster than traditional alignment-based methods.

## Installation and Database Setup

GAMBIT is primarily distributed via Bioconda.

```bash
conda install -c bioconda gambit
```

### Reference Database
The tool requires two specific database files to function:
1. `gambit-refseq-curated-1.0.gdb`
2. `gambit-refseq-curated-1.0.gs`

**Critical:** You must define the location of these files. The most efficient method is setting an environment variable in your shell profile:
```bash
export GAMBIT_DB_PATH=/path/to/database/directory/
```

## Command Line Usage

The primary function of GAMBIT is executed through the `query` subcommand.

### Basic Identification
To identify one or more bacterial genome assemblies (FASTA format):
```bash
gambit query genome1.fasta genome2.fasta
```

### Specifying Database Path Manually
If the environment variable is not set, the database path must be provided **before** the subcommand:
```bash
gambit -d /path/to/database/ query sample.fasta
```

### Output Management
By default, GAMBIT outputs results to the terminal. Use the `-o` flag to save results to a CSV file for downstream analysis:
```bash
gambit query -o identification_results.csv *.fasta
```

### Enhanced Readability
For a more human-readable terminal output, use the `--pretty` flag:
```bash
gambit query --pretty sample.fasta
```

## Best Practices and Expert Tips

- **Input Formats**: GAMBIT accepts standard FASTA/FNA files. Ensure your assemblies are reasonably contiguous for the best distance approximation.
- **Batch Processing**: You can pass multiple positional arguments or use wildcards (e.g., `*.fna`) to process entire directories of assemblies in a single command.
- **Performance**: Because GAMBIT uses a distance-based approximation rather than full alignment, it is extremely memory-efficient. It can be run on standard laptops as easily as high-performance computing clusters.
- **Version Consistency**: Ensure your database version matches the tool version requirements. The current curated database is version 1.0.

## Reference documentation

- [GAMBIT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gambit_overview.md)
- [GAMBIT GitHub Repository](./references/github_com_jlumpe_gambit.md)
- [GAMBIT Commit History](./references/github_com_jlumpe_gambit_commits_master.md)