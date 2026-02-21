---
name: genoflu
description: GenoFLU is a specialized bioinformatics pipeline developed by the USDA for the classification of highly pathogenic avian influenza (HPAI) H5N1.
homepage: https://github.com/USDA-VS/GenoFLU
---

# genoflu

## Overview

GenoFLU is a specialized bioinformatics pipeline developed by the USDA for the classification of highly pathogenic avian influenza (HPAI) H5N1. It automates the identification of genotypes by comparing all eight viral gene segments against a curated reference database using BLAST. The tool is essential for distinguishing between pure Eurasian viruses (A-type) and various reassortant types (B, C, and D) that have mixed with North American low pathogenic lineages.

## Installation and Setup

GenoFLU is best managed via Conda to ensure all dependencies (like BLAST) are correctly configured.

```bash
# Create and activate the environment
conda create -c conda-forge -c bioconda -n genoflu genoflu
conda activate genoflu
```

## Command Line Usage

The primary interface is the `genoflu.py` script. It requires a FASTA file containing the influenza genome segments.

### Basic Execution
```bash
genoflu.py -f <your_genome.fasta>
```

### Adjusting Sensitivity
By default, GenoFLU uses a 98% identity threshold to classify a segment. You can modify this using the `-p` flag:
```bash
# Lower the threshold to 95% for more divergent samples
genoflu.py -f <your_genome.fasta> -p 95.0
```

## Interpreting Results

GenoFLU produces both Excel and tab-delimited outputs. Understanding the "Genotype" column is critical:

*   **Specific Genotype (e.g., A1, B3.2):** All 8 segments matched known reference types and the combination matches an established genotyping scheme.
*   **Not assigned: No Matching Genotypes:** All 8 segments met the identity threshold (>98%), but the specific combination of segments does not match any known genotype in the database.
*   **Not assigned: Only X segments >98% match found:** One or more segments failed to meet the identity threshold against the reference database.

### Console Output Format
The tool provides a summary line for quick inspection:
`sample_name Genotype --> A1: PB2:ea1, PB1:ea1, PA:ea1, HA:ea1, NP:ea1, NA:ea1, MP:ea1, NS:ea1 at percent identity at 98.0`

## Expert Tips

*   **Input Preparation:** Ensure your FASTA file contains all eight segments for a complete genotype assignment. While the tool will run on partial genomes, it will result in a "Not assigned" status if fewer than 8 segments are identified.
*   **Database Updates:** GenoFLU relies on a curated database in its `dependencies` directory. If you are working with very recent or highly divergent outbreaks, check for tool updates to ensure the reference library includes the latest known genotypes (e.g., the B3.13 genotype associated with dairy cattle).
*   **Reassortment Detection:** Use the "Genotype List Used" output to manually inspect which segments are Eurasian (ea) vs North American (am) when a sample is flagged as "No Matching Genotypes." This often indicates a novel reassortment event.

## Reference documentation
- [GenoFLU Overview](./references/anaconda_org_channels_bioconda_packages_genoflu_overview.md)
- [GenoFLU GitHub Repository](./references/github_com_USDA-VS_GenoFLU.md)