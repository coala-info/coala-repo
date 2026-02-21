---
name: hypro
description: HyPro is a Nextflow-based pipeline that automates the refinement of bacterial genome annotations.
homepage: https://github.com/hoelzer-lab/hypro.git
---

# hypro

## Overview
HyPro is a Nextflow-based pipeline that automates the refinement of bacterial genome annotations. While Prokka is excellent for rapid annotation, it often leaves a high percentage of genes labeled as "hypothetical protein." This skill leverages HyPro to take those sequences, search them against comprehensive protein databases via MMseqs2, and update the original GFF/GBK files with more specific functional descriptions based on homology.

## Core Workflows

### Basic Annotation Extension
To run the pipeline on a single genome using the default UniProtKB database:
```bash
nextflow run hoelzer-lab/hypro \
  -profile local,conda \
  --fasta path/to/genome.fna \
  --database uniprotkb
```

### Batch Processing
For multiple genomes, use a CSV file (format: `sample_id,path/to/fasta`) and the `--list` flag:
```bash
nextflow run hoelzer-lab/hypro \
  -profile local,conda \
  --fasta samples.csv \
  --list true
```

### Using Custom or Pre-downloaded Databases
To avoid repeated downloads or use a specific local database:
```bash
nextflow run hoelzer-lab/hypro \
  -profile local,conda \
  --fasta genome.fna \
  --database uniprotkb \
  --customdb /path/to/existing/db_folder
```

## Parameter Tuning

### Search Sensitivity
Adjust the homology search stringency using e-value and identity thresholds:
- `--evalue`: Default is 0.1. Lower values (e.g., `1e-5`) increase confidence.
- `--pident`: Default is 0.0. Set to `0.3` or higher for more reliable functional assignments.
- `--min-aln-len`: Minimum alignment length to consider a hit valid.

### Modus Selection
- `--modus full`: (Default) Searches all proteins labeled as hypothetical.
- `--modus restricted`: Skips proteins that already have partial annotations (useful for UniProt-specific workflows).

## Best Practices
- **Resource Management**: Use `--threads` to specify CPU allocation for the MMseqs2 search step.
- **Database Choice**: `uniprotkb` is the default and generally sufficient. `uniref90` or `uniref100` provide higher resolution but significantly increase runtime and storage requirements.
- **Output Inspection**: The updated annotation files (GFF, GBK, FAA, FFN) are located in the `prokka_restored_updated/` subdirectory within the results folder.
- **Prokka Customization**: If your organism uses a non-standard genetic code, pass the necessary flags via the `--prokka` parameter (e.g., `--prokka "--gcode 11 --gram pos"`).

## Reference documentation
- [HyPro GitHub Repository](./references/github_com_hoelzer-lab_hypro.md)
- [HyPro Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hypro_overview.md)