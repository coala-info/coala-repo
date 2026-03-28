---
name: drep
description: dRep compares and de-replicates microbial genome sets to identify clusters of similar genomes and select the highest-quality representatives. Use when user asks to compare genome similarity, de-replicate genome sets, or cluster genomes based on average nucleotide identity.
homepage: https://github.com/MrOlm/drep
---


# drep

## Overview

dRep is a specialized tool for the rapid comparison and de-replication of microbial genome sets. It automates the process of identifying clusters of highly similar genomes and selecting the highest-quality representative from each cluster. This is particularly useful in metagenomics to reduce redundancy in genome-resolved datasets. The tool operates through a two-stage clustering process: a fast primary clustering (usually via Mash) followed by a more sensitive secondary clustering (usually via ANIm or FastANI).

## Core Commands

### Dependency Verification
Before running analysis, ensure all external dependencies (Mash, MUMmer, etc.) are available:
```bash
dRep check_dependencies
```

### Genome Comparison
Use this to generate similarity matrices and clusters without selecting representatives:
```bash
dRep compare <output_directory> -g /path/to/genomes/*.fasta
```

### Genome De-replication
Use this to cluster genomes and pick the best representative for each cluster based on quality:
```bash
dRep dereplicate <output_directory> -g /path/to/genomes/*.fasta
```

## Expert CLI Patterns

### Handling Large Datasets (>5,000 genomes)
For massive datasets, use multi-round primary clustering and memory-efficient options to prevent crashes:
```bash
dRep dereplicate <out_dir> -g /path/to/genomes/*.fasta --multiround_primary_clustering --low_ram_primary_clustering
```

### Optimizing for Speed
FastANI is significantly faster than the default MUMmer (ANIm) for secondary clustering:
```bash
dRep dereplicate <out_dir> -g /path/to/genomes/*.fasta -S_algorithm fastANI
```

### Quality-Based Selection
If you have pre-calculated genome information (like CheckM results), provide it to improve the "best" genome selection:
```bash
dRep dereplicate <out_dir> -g /path/to/genomes/*.fasta --genomeInfo <quality_info.csv>
```

### Ignoring Quality Filtering
If you want to de-replicate based on similarity alone without filtering out "low-quality" genomes:
```bash
dRep dereplicate <out_dir> -g /path/to/genomes/*.fasta --ignoreGenomeQuality
```

## Common Parameters and Tips

- **-g / --genomes**: Can accept a glob (e.g., `*.fasta`) or a text file containing a list of paths to genomes.
- **-sa / --S_ani**: Sets the Average Nucleotide Identity (ANI) threshold for secondary clustering (default is 0.99 for dereplicate, 0.95 for compare).
- **-nc / --cov_thresh**: Sets the minimum alignment coverage threshold (default 0.1).
- **-comp / --completeness**: Minimum completeness for a genome to be considered (default 75).
- **-con / --contamination**: Maximum contamination for a genome to be considered (default 25).



## Subcommands

| Command | Description |
|---------|-------------|
| compare | Compare genomes to find similar ones |
| dereplicate | Dereplicate genomes based on ANI and other quality metrics. |
| drep_dRep | Check dependencies for dRep |

## Reference documentation
- [dRep GitHub Repository](./references/github_com_MrOlm_drep.md)
- [dRep README](./references/github_com_MrOlm_drep_blob_master_README.md)
- [dRep Change Log](./references/github_com_MrOlm_drep_blob_master_CHANGELOG.md)