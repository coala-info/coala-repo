---
name: labrat
description: LABRAT (Lightweight Alignment-Based Reckoning of Alternative Three-prime ends) provides a specialized workflow for measuring the relative abundance of alternative 3' UTR isoforms.
homepage: https://github.com/TaliaferroLab/LABRAT
---

# labrat

## Overview

LABRAT (Lightweight Alignment-Based Reckoning of Alternative Three-prime ends) provides a specialized workflow for measuring the relative abundance of alternative 3' UTR isoforms. It calculates a "psi" ($\psi$) value for each gene, where 0 represents exclusive usage of the most upstream APA site and 1 represents exclusive usage of the most downstream site. By leveraging the quasi-mapping capabilities of `salmon`, LABRAT accurately assigns reads to specific 3' UTRs even when sequences heavily overlap, overcoming the limitations of traditional count-based alignment methods.

## Installation and Environment

The most reliable way to use LABRAT is via the Bioconda package:

```bash
conda install -c bioconda labrat
```

Note: LABRAT currently requires `salmon` versions < 1.0.0. If using a manual installation, ensure a compatible environment is active.

## Core Workflow

The LABRAT pipeline consists of three sequential modes.

### 1. makeTFfasta
Generate a specialized fasta file of terminal fragments (TFs) for quantification.

```bash
LABRAT.py --mode makeTFfasta --gff <annotation.gff> --genomefasta <genome.fasta>
```

- **GFF Requirement**: Use Gencode annotations for human/mouse. Ensure the GFF is uncompressed.
- **Output**: Creates a fasta file containing the sequences used for salmon indexing.

### 2. runSalmon
Quantify transcript abundance using the generated TF fasta.

```bash
LABRAT.py --mode runSalmon --txfasta <TF_fasta> --reads1 <R1.fastq> --reads2 <R2.fastq> --samplename <name> --threads <int>
```

- **Library Types**: Specify `--librarytype RNAseq` (default) or `--librarytype 3pseq`.
- **RNAseq**: Quantifies the last two exons; uses length-normalized TPM values.
- **3pseq**: Quantifies the last 300nt; uses raw read counts.

### 3. calculatepsi
Calculate $\psi$ values and perform differential APA analysis between conditions.

```bash
LABRAT.py --mode calculatepsi --gff <annotation.gff> --sampconds <conditions.csv>
```

- **Conditions File**: A CSV file mapping sample names to experimental conditions.
- **Output**: A table containing $\psi$ values, $\Delta\psi$ (change in site usage), and significance metrics.

## Species-Specific Annotations

For non-Gencode species, use the specialized annotation scripts provided in the package:

- **Drosophila (dm6)**: Use `LABRAT_dm6annotation.py` to process Ensembl GFF files.
- **Rat (rn6)**: Use `LABRAT_rn6annotation.py`.
- **Zebrafish (danRer)**: Use `LABRAT_danRer.py`.

## Expert Tips and Best Practices

- **Resolution**: If a gene has multiple APA sites, an increase in $\psi$ indicates a shift toward distal (downstream) sites, while a decrease indicates a shift toward proximal (upstream) sites.
- **Expression Thresholds**: LABRAT automatically filters low-expression genes (default: 5 TPM for RNAseq, 100 counts for 3pseq). Adjust these if working with low-depth libraries.
- **Salmon Directory**: If `salmon` is not in your PATH, specify its location using the `--salmondir` flag.
- **Single Cell**: For single-cell data, utilize the `LABRATsc.py` variant designed for sparse quantification.

## Reference documentation
- [LABRAT Overview and Usage](./references/github_com_TaliaferroLab_LABRAT.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_labrat_overview.md)