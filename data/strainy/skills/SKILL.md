---
name: strainy
description: Strainy reconstructs individual bacterial strains from complex metagenomic samples by phasing variants in long-read assembly graphs. Use when user asks to reconstruct strain-level haplotypes, phase variants in metagenomic data, or distinguish between closely related bacterial strains using long reads.
homepage: https://github.com/katerinakazantseva/strainy
metadata:
  docker_image: "quay.io/biocontainers/strainy:1.2--pyhdfd78af_1"
---

# strainy

## Overview
Strainy is a specialized tool for reconstructing individual bacterial strains from complex metagenomic samples using long-read data. While standard assemblers often collapse closely related strains into a single consensus sequence, Strainy uses a graph-based approach to phase variants and distinguish between abundant or divergent strains. It is most effective when used in conjunction with de novo metagenomic assembly graphs (like those from metaFlye) to produce strain-level haplotypes and phased alignments.

## Installation and Setup
The most reliable way to install Strainy is via Conda or Mamba:
```bash
conda install bioconda::strainy
# OR
mamba install strainy
```

## Core Workflow
The standard end-to-end (e2e) execution requires an assembly graph and the corresponding long reads.

### Basic Command Pattern
```bash
strainy.py --gfa_ref assembly.gfa --fastq reads.fastq.gz --output out_dir --mode [hifi|nano] --threads 8
```

### Input Requirements
- **Reference**: Either a `.gfa` graph (recommended) or a `.fasta` linear reference.
- **Reads**: FASTQ/FASTA files containing PacBio HiFi or Nanopore (R9/R10) reads.
- **Mode**: Must specify `hifi` for PacBio or `nano` for Nanopore.

## Expert Tips and Best Practices

### 1. Optimizing metaFlye for Strainy
If generating the input GFA with metaFlye, use these specific parameters to ensure the graph retains the structural variations Strainy needs:
- `--meta`: Enable metagenomic mode.
- `--keep-haplotypes`: Retain structural variations between strains.
- `--no-alt-contigs`: Prevents outputting alternative contigs that confuse the aligner.
- `-i 0`: Disables polishing, which improves read assignment to bubble branches during realignment.

### 2. Handling Long Unitigs
Strainy splits unitigs longer than 50kb by default to maintain performance. 
- If you provide your own BAM and VCF files, you **must** disable splitting: `--unitig-split-length 0`.
- If the process is running slowly on large assemblies, ensure unitigs are split using the `--only-split` option before generating custom alignments.

### 3. Tuning Phasing Sensitivity
- **Coverage Thresholds**: Use `--min-unitig-coverage` (default 20) and `--max-unitig-coverage` (default 500) to exclude unitigs that are too sparse to phase or likely represent repetitive regions/over-represented species.
- **Cluster Divergence**: Adjust `--cluster-divergence` based on expected SNP rates. Higher values reduce fragmentation but may decrease clustering accuracy.

### 4. Staged Execution
You can run specific parts of the pipeline using the `--stage` flag:
- `phase`: Only perform the phasing of variants.
- `transform`: Only perform the graph transformation based on existing phasing.
- `e2e`: Run the full pipeline (default).

## Interpreting Key Outputs
- `alignment_phased.bam`: The input reads aligned and tagged with `YC` tags indicating their phase/strain assignment.
- `strain_unitigs.gfa`: The transformed assembly graph incorporating the resolved strain haplotypes.
- `strain_variants.vcf`: Phased variant calls specific to the identified strains.

## Reference documentation
- [Strainy GitHub Repository](./references/github_com_katerinakazantseva_strainy.md)
- [Bioconda Strainy Overview](./references/anaconda_org_channels_bioconda_packages_strainy_overview.md)